
function _oci() {
  echo "$( oci $@ | jq -s '.[0].data' )"
}

function refresh_compartments() {
  OCI_COMPARTMENTS="$( _oci iam compartment list --compartment-id-in-subtree true )"
}

function get_compartment_id() {
  echo $OCI_COMPARTMENTS | jq -r --arg target "$1" '.[] | select(.name == $target ).id'
}

function set_compartment_context() {
  OCI_CONTEXT_COMPARTMENT="$( get_compartment_id $1 )"
}
