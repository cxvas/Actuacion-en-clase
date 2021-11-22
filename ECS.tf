resource "aws_ecs_cluster" "ECS-PyG" {
  name               = "cluster_pyg"
  capacity_providers = ["FARGATE"]

  setting {
    name  = "containerInsights"
    value = "disabled"
  }
}