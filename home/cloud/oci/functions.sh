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

function customer_stack() {
  echo "$( oci resource-manager stack list --compartment-id "$(my_compartment_id)" --display-name "$1" )"
}

function most_recent_job() {
  oci resource-manager job list --stack-id "$(customer_stack "$1" | jq -r '.data[].id')" | jq -r '.data | sort_by(."time-created") | .[-1]'
}

function job_logs() {
  echo -e "$(oci resource-manager job get-job-logs-content --job-id "$(most_recent_job "$1" | jq -r '.id')" | jq -r '.data')"
}

function get_instance() {
  local -r compartment_id="$(compartment_id $1)"
  local -r instance_name="$2"
  oci compute instance list --compartment-id $compartment_id --lifecycle-state RUNNING | jq --arg v "$instance_name" '.data[] | select(."display-name" | contains($v))'
}

function get_public_ip() {
  local -r compartment_id="$(compartment_id $1)"
  local -r instance_id="$(get_instance $compartment_id $2 | jq -r '.id')"
  local -r vnic_id="$(oci compute vnic-attachment list --compartment-id $compartment_id | jq -r --arg v "$instance_id" '.data[] | select(."instance-id"==$v) | ."vnic-id"')"
  oci network vnic get --vnic-id $vnic_id | jq -r '.data."public-ip"'
}