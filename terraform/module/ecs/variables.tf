variable "ecs_name" {
  description = "the name for ecs"
  default = ""
}

variable "security_group" {
  description = "the sg for ecs"
  default = ""
}

variable "account" {
  description = "aws account ID"
  default = ""
}

variable "ecs_tags" {
  description = "the tags for ecs repo"
  type = map(string)
}

