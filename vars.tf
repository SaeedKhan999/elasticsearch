variable "profile" {
  default = "elastic" # aws credential profile
}

variable "region" {
  default = "us-east-2" # region where you want to launch your resources
}
variable "env" {
  default = "dev" # valid values: dev, stage and prod
}
