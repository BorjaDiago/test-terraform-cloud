cidr_paris = "10.10.0.0/16"

subnets = {
  public  = "10.10.0.0/24",
  private = "10.10.1.0/24"
}

tags = {
  "env"        = "dev",
  "owner"      = "DevOps Team",
  "created_by" = "terraform",
  "managed_by" = "Borja Diago",
  "cloud"      = "aws"
  "region"     = "eu-west-3"
  "project"    = "practica-terraform"
}

sg_ingress_cidr = "0.0.0.0/0"

instance_type = "t2.micro"
ami_value     = "ami-009d5fce35d17d28c"

enable_monitoring = false

ingress_port_list = [22, 80, 443]