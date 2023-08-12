resource "aws_alb" "alb" {
    name = "AECapital_alb"
    subnets = aws_subnet.subnet_public.*.id
    security_groups = [aws_security_group.secgroup_alb.id]
    tags                 = var.ecr_tags
}

resource "aws_alb_target_group" "target_group" {
    name = "AECapital-target-group"
    target_type = "ip"
    port = 80
    protocol = "HTTP"
    vpc_id = aws_vpc.vpc.id
}

resource "aws_alb_listener" "alb_listener" {
    load_balancer_arn = aws_alb.alb.id
    port = 80
    protocol = "HTTP"
    

    default_action {
        target_group_arn =aws_alb_target_group.target_group.id
        type = "forward"
    }
}