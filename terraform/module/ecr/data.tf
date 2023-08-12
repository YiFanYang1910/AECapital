# data "aws_iam_policy_document" "policy" {
  
#   statement {
#     sid = "AllowPushPull"
#     effect = "Allow"
#     actions = [ 
#         "ecr:BatchGetImage",
#         "ecr:BatchCheckLayerAvailability",
#         "ecr:CompleteLayerUpload",
#         "ecr:GetDownloadUrlForLayer",
#         "ecr:InitiateLayerUpload",
#         "ecr:PutImage",
#         "ecr:UploadLayerPart",
#         "ecr:DescribeRepositories",
#         "ecr:ListImages",
#         "ecr:DescribeImages"
#      ]
#     principals {
#       type = "AWS"
#       identifiers = var.allowed_principals
#     }
#   }
# }