
#Creacion de VPC y Gateway

resource "aws_vpc" "vpc_dogcats" {
  cidr_block           = "172.30.0.0/16"
  enable_dns_support   = "true"
  enable_dns_hostnames = "true"

  tags = {
    Name        = "vpc_dogcats"
    Description = "VPC vpc_dogcats"
  }
}

resource "aws_internet_gateway" "GW_vpc_dogcats" {
  vpc_id = aws_vpc.vpc_dogcats.id

  tags = {
    Name = "GW-VPC dogcats"
  }
}

# Subnets 

resource "aws_subnet" "AZ_dogcats" {

  count = var.cant_subnets

  vpc_id            = aws_vpc.vpc_dogcats.id
  cidr_block        = element(var.subnet_cidr, count.index)
  availability_zone = element(var.AZ_dogcats, count.index)

  tags = {
    Name        = "AZ${count.index}_Subnet_dogcats_${count.index}"
    Description = "Subnet de Instancias"
  }

}

#Tabla de Rutas para el VPC dogcats

resource "aws_route_table" "tabla_vpc_dogcats" {
  vpc_id = aws_vpc.vpc_dogcats.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.GW_vpc_dogcats.id
  }

  tags = {
    Name = "Tabla de rutas vpc_dogcats"
  }
}

resource "aws_main_route_table_association" "Main_tabla_vpc_dogcats" {
  vpc_id         = aws_vpc.vpc_dogcats.id
  route_table_id = aws_route_table.tabla_vpc_dogcats.id
}