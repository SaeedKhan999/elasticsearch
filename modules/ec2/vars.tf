variable "ubuntu_ami" {
    default = "ami-08962a4068733a2b6"
}

variable "instance_type" {
    default = "t2.micro"
}

variable "key" {
    default = "gitlab-key"
}

variable "pub_sub1_id" {}

variable "sg_id" {}

variable "userdata" { }

variable "env" {}

variable "region" {}
