module "ecr_AECapital" {
  source = "../../module/ecs"

  ecs_name = var.ecs_name
  security_group = var.security_group
  account = var.account
  ecs_tags = merge(var.ecs_tags,{
    name = "AECapital"
    }
  )
}