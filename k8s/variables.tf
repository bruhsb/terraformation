## TODO: Create Docs

# ##########################
# ### GENERAL  VARIABLES ###
# ##########################

locals {

  project_id     = data.terraform_remote_state.gcp_project.outputs.project_id
  gcp_project_id = data.terraform_remote_state.gcp_project.outputs.gcp_project_id
  gcp_region     = data.terraform_remote_state.gcp_project.outputs.gcp_region
  gcp_zone       = data.terraform_remote_state.gcp_project.outputs.gcp_zone
  gke_endpoint   = data.terraform_remote_state.gcp_project.outputs.gke_endpoint
  gke_ca         = data.terraform_remote_state.gcp_project.outputs.gke_ca
}
