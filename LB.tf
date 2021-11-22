resource "aws_lb" "LB_pyg" {
  name               = "LB-pyg"
  load_balancer_type = "application"
  internal           = false
  ip_address_type    = "ipv4"

  enable_deletion_protection = false

  security_groups = [aws_security_group.puertos-cluster.id]
  subnets         = aws_subnet.AZ_dogcats.*.id

  depends_on = [aws_internet_gateway.GW_vpc_dogcats]

  tags = {
    Entorno     = "Produccion"
    Description = "Balanceador del sitio pyg"
  }
}

resource "aws_lb_target_group" "LB_pyg_App_Pool" {
  name        = "LB-pyg-App-Pool"
  target_type = "ip"
  port        = 80
  protocol    = "HTTP"
  vpc_id      = aws_vpc.vpc_dogcats.id
}

/* resource "aws_lb_target_group_attachment" "LB_pyg_tg" {
  count            = var.cant_instancias
  target_group_arn = aws_lb_target_group.LB_pyg_App_Pool.arn
  target_id        = aws_instance.Instancia_App_Web[count.index].id
  port             = 80
} */

resource "aws_lb_listener" "LB_pyg_listener" {
  load_balancer_arn = aws_lb.LB_pyg.arn
  port              = "80"
  protocol          = "HTTP"

  default_action {
    type             = "forward"
    target_group_arn = aws_lb_target_group.LB_pyg_App_Pool.arn
  }
}