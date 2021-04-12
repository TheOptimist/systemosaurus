function compartment_id() {
  if [[ "$1" = ocid1.compartment* ]]; then
    echo $1
  else
    local all_compartments="$( oci iam compartment list --compartment-id-in-subtree true --all )"
    echo "${all_compartments}" | jq -r --arg value "$1" '.data[] | select(.name==$value) | .id'
  fi
}

function my_compartment_id() {
  compartment_id 'cover'
}

function get_stack() {
  oci resource-manager stack list --compartment-id "$(my_compartment_id)" --sort-by TIMECREATED --sort-order DESC | jq --arg s "$1" '[.data[] | select(."display-name" | startswith($s))][0]'
}

function most_recent_job() {
  oci resource-manager job list --stack-id "$(get_stack "$1" | jq -r '.id')" | jq -r '.data | sort_by(."time-created") | .[-1]'
}

function job_logs() {
  local -r logs="$(oci resource-manager job get-job-logs-content --job-id "$(most_recent_job "$1" | jq -r '.id')" | jq -r '.data')"
  if [[ -n "${2+x}" ]]; then
    local output="$( echo $logs | grep -v ' module.')"
    for module in "${@:2}"; do
      echo "Finding content in logs for $module"
      module_output="$( echo $logs | grep $module )"
      output="$( echo $output + $module_output) "
    done
    echo -e $output | sort
  else
    echo -e $logs
  fi
}

function get_instance() {
  local -r compartment_id="$(compartment_id $1)"
  local -r instance_name="$2"
  oci compute instance list --compartment-id $compartment_id --lifecycle-state RUNNING | jq --arg v "$instance_name" '.data[] | select(."display-name" | contains($v))'
}

function get_public_ip() {
  local -r compartment_id="$(compartment_id $1)"
  local -r instance_id="$(get_instance $compartment_id $2 | jq -r '.id')"
  local -r vnic_id="$(oci compute vnic-attachment list --compartment-id $compartment_id --all | jq -r --arg v "$instance_id" '.data[] | select(."instance-id"==$v) | ."vnic-id"')"
  oci network vnic get --vnic-id $vnic_id | jq -r '.data."public-ip"'
}

function get_stack_outputs {
  local -r stack_id="$( get_stack $1 | jq -r '.id' )"
  local -r jobs="$( oci resource-manager job list --compartment-id $(my_compartment_id) --stack-id ${stack_id} --sort-by TIMECREATED --sort-order DESC )"
  local -r latest_job_id="$( echo "$jobs" | jq '.data[] | select (. | .operation == "APPLY")' | jq -rs '.[0].id' )"
  local -r state_file=$(mktemp)
  oci resource-manager job get-job-tf-state --job-id ${latest_job_id} --file "${state_file}"
  local -r readonly outputs="$(cat "$state_file" | jq .outputs)"
  rm -f "$state_file"
  echo $outputs | tr -d '\n\r\t'
}