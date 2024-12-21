/**
 * Create the root folder, all the resources will be created under this folder
 *
 * Created December 14th, 2024
 * @author ywarezk
 */

include "root" {
  path = find_in_parent_folders()
}

include "folder" {
  path = "${dirname(find_in_parent_folders())}/_env/folder.hcl"
}

inputs = {
  names = ["academeez-k8s-flux"]
}