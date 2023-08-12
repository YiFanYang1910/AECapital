module "ecr_AECapital" {
  source = "../../module/ecr"

  ecr_name = var.ecr_name
  ecr_tags = merge(var.ecr_tags,{
    name = "AECapital"
    component = "AECapital-image"
    }
  )

#   repo_policy_create = var.repo_policy_create
#   allowed_principals = var.allowed_principals
}