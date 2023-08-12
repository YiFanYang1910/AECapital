resource "aws_ecs_cluster" "AECapital_ecs" {
  name = var.ecs_name
  tags                 = var.ecr_tags
}

resource "aws_ecs_service" "AECapital_ecs_service" {
  name = "${var.ecs_name}_service"
  cluster = aws_ecs_cluster.AECapital_ecs.id
  task_definition = aws_ecs_task_definition.AECapital_ecs_task_definition.arn
  desired_count = var.desired_count
  launch_type = "FARGATE"

  network_configuration {
    
  }

  load_balancer {
    
  }
}

resource "aws_ecs_task_definition" "AECapital_ecs_task_definition" {
  family = "${var.ecs_name}_task_definition"
  requires_compatibilities = ["FARGATE"]
  network_mode = "awsvpc"
  cpu = 1024
  memory = 2048
  execution_role_arn = aws_iam_role.ecs_exec_role.arn
  task_role_arn = aws_iam_role.ecs_exec_role.arn
//for best practices, we should created 2 roles for permission limit
    container_definitions = <<DEFINITION
    [
    {
        "image": "${var.account}.dkr.ecr.ap-southeast-2.amazonaws.com/AECapital:0.0.1",
        "name": "AECapital",
        "logConfiguration": {
                    "logDriver": "awslogs",
                    "options": {
                        "awslogs-region" : "ap-southeast-2",
                        "awslogs-group" : "AECapital-ecs",
                        "awslogs-stream-prefix" : "project"
                    }
                },
        "portMappings": [
            {
        "containerPort": 3000,
        "hostPort": 3000
            }
        ]
    }
    ]
    DEFINITION
}

resource "aws_iam_role" "ecs_exec_role" {
  name = "ecs_execution_role"
  assume_role_policy = data.aws_iam_policy_document.ecs_role_policy.json
}

data "aws_iam_policy_document" "ecs_role_policy" {
  statement {
    actions = ["sts:AssumeRole"]

  
  principals{
    type = "Service"
    identifiers = ["ecs-tasks.amazonaws.com"]
    }
  }
}

resource "aws_iam_role_policy_attachment" "ecs_exec_role_policy" {
  role = aws_iam_role.ecs_exec_role.name
  policy_arn = "arn:aws:iam::aws:policy/service-role/AmazonEC2ContainerServiceforEC2Role"
}