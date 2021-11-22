variable "Profile_Terraform" {
  type    = string
  default = "Terraform"
}

variable "Region_Terraform" {
  default = "us-east-1"
}

variable "AZ_dogcats" {
  type    = list(any)
  default = ["us-east-1a", "us-east-1b"]
}

variable "subnet_cidr" {
  type    = list(any)
  default = ["172.30.11.0/24", "172.30.12.0/24"]
}

variable "cant_subnets" {
  default = 2
}