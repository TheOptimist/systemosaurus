function compartment_id() {
  local all_compartments="$( oci iam compartment list --compartment-id-in-subtree true --all )"
  echo "${all_compartments}" | jq -r --arg value "$1" '.data[] | select(.name==$value) | .id'
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
