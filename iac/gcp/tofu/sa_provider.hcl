#
# This gives me the  power to override who the service account we need to impersonate to create
# This resource
# 
# Created May 8th, 2024
# @author ywarezk
# @license MIT
#

locals {
  common_vars = yamldecode(file("common_vars.yaml"))
  sa_provider = local.common_vars.sa_course
}