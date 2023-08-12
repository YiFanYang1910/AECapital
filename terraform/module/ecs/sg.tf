resource "aws_security_group" "secgroup_alb" {
  name = "${var.security_group}_alb"
  description = "security group for alb to allow/deny traffic"
  vpc_id = aws_vpc.vpc.id
  tags                 = var.ecr_tags

  ingress {
    description = "allowed traffic"
    from_port = 80
    to_port = 80
    #strat to end port range
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  egress{
    description = "blocked traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}



resource "aws_security_group" "secgroup_task_definition"{
    name = "${var.security_group}_task_definition"
    description = "security group for ecs to allow/deny traffic"
    vpc_id = aws_vpc.vpc.id

  ingress {
    description = "allowed traffic"
    from_port = 3000
    to_port = 3000
    protocol = "tcp"
    security_groups = [aws_security_group.secgroup_alb.id]
    
  }

  egress{
    description = "blocked traffic"
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
    }
}