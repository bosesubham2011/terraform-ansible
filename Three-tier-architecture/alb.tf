# Creating External LoadBalancer
resource "aws_lb" "external-alb-america" {
  name               = "External LB"
  internal           = false
  load_balancer_type = "application"
  security_groups    = [aws_security_group.alb-sg-america.id]
  subnets            = [aws_subnet.public-subnet-america-1.id, aws_subnet.public-subnet-america-2.id]
}

resource "aws_lb_target_group" "targetgroup-alb-america" {
  name     = "targetgroup-alb-america"
  port     = 80
  protocol = "HTTP"
  vpc_id   = aws_vpc.main-vpc-america.id
}

resource "aws_lb_target_group_attachment" "targetgroupattachment-america-1" {
  target_group_arn = aws_lb_target_group.targetgroup-alb-america.arn
  target_id        = aws_instance.ansible-master-america.id
  port             = 80

  depends_on = [
    aws_instance.ansible-master-america,
  ]
}

resource "aws_lb_listener" "listeneralb-america" {
  load_balancer_arn = aws_lb.external-alb-america.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.targetgroup-alb-america.arn
  }
}