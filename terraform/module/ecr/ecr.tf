resource "aws_ecr_repository" "aecapital_ecr" {
    name                 = var.ecr_name
    image_tag_mutability = "IMMUTABLE"
    tags                 = var.ecr_tags

    image_scanning_configuration {
      scan_on_push = true
    }
}

# resource "aws_ecr_registry_scanning_configuration" "ecr_scan_config" {
#   scan_type = var.scan_type
  
#   dynamic "rule" {
#     for_each = var.scan_rules
    
#     content {
#       scan_frequency = rule.value.scan_frequency

#       repository_filter {
#         filter = rule.value.filter
#         filter_type = try(rule.value.filter_type, "WILDCARD")
#       }
#     }
#   }  
# }

# resource "aws_ecr_repository_policy" "repo_policy" {
#   repository = aws_ecr_repository.aecapital_ecr.name
#   policy = var.repo_policy_create ? data.aws_iam_policy_document.policy[0].json : null
#   depends_on = [ 
#     aws_ecr_repository.aecapital_ecr 
#     ]
# }