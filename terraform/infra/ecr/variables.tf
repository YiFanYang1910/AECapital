variable "ecr_name" {
  description = "the name for ecr repo"
  default = ""
}

variable "ecr_tags" {
  description = "the tags for ecr repo"
  type = map(string)
}

# variable "scan_type" {
#   description = "scanning type to set to registry"
#   type = string
#   default = "BASIC"
# }

# variable "scan_rules" {
#   description = "specifying scanning rules to determine which repo filter are used"
#   type = any
#   default = []
# }

# variable "repo_policy_create" {
#   description = "flag to enable repo policy"
#   type = bool
#   default = false
# }

# variable "allowed_principals" {
#   description = "allow external ARN to write to the ECR"
#   type = list(string)
#   default = []
# }