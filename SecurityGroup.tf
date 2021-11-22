#SG para acceso desde Interent a los nodos

resource "aws_security_group" "puertos-cluster" {
  name        = "puertos-cluster"
  description = "SG asociado al Load Balancer"
  vpc_id      = aws_vpc.vpc_dogcats.id

  ingress = [{
    description      = "Puerto HTTP"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = []
    prefix_list_ids  = []
    security_groups  = []
    self             = false
    }
  ]

  egress = [
    {
      description      = "Puertos de salida habilitados"
      from_port        = 0
      to_port          = 0
      protocol         = "-1"
      cidr_blocks      = ["0.0.0.0/0"]
      ipv6_cidr_blocks = []
      prefix_list_ids  = []
      security_groups  = []
      self             = false
    }

  ]

  tags = {
    Name = "SG_cluster_dogcats"
  }
}