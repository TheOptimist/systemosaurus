function compartment_id() {
  oci iam compartment list --compartment-id-in-subtree true \
  | jq -r --arg value "$1" '.data[] | select(.name==$value) | .id'
}

function my_compartment_id() {
  if [[ -z ${MY_COMPARTMENT_ID+x} ]]; then
    MY_COMPARTMENT_ID="$(compartment_id 'cover')"
  fi
  echo "${MY_COMPARTMENT_ID}"
}

function customer_stack() {
  if [[ -z ${CUSTOMER_STACK} ]]; then
    CUSTOMER_STACK="$(oci resource-manager stack list --compartment-id "$(my_compartment_id)" --display-name "$1")"
  fi
  echo "${CUSTOMER_STACK}"
}

function most_recent_job() {
  oci resource-manager job list --stack-id "$(customer_stack | jq -r '.data[].id')" | jq -r '.data | sort_by(."time-created") | .[-1]'
}

function job_logs() {
  echo -e "$(oci resource-manager job get-job-logs-content --job-id "$(most_recent_job | jq -r '.id')" | jq -r '.data')"
}
