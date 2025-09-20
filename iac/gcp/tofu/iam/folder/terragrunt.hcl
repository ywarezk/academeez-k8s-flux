/**
 * This will create the iam folder
 * All iam cloud resources will be grouped under this folder
 * root -> iam
 *
 * Created April 18th, 2025
 * @author: ywarezk
 */

include "root" {
  path = find_in_parent_folders("root.hcl")
}

include "folder" {
  path = "${dirname(find_in_parent_folders("root.hcl"))}/_env/folder.hcl"
}

# since this folder is under the root folder we will use dependency to get the parent folder
dependency "root_folder" {
  config_path = "../../common/folders/root"
}

inputs = {
  parent              = dependency.root_folder.outputs.id
  deletion_protection = false
  names               = ["iam2"]
}