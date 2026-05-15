variable "aws_region" {
  default = "eu-west-1"
}

variable "environment" {
  default = "lab"
}

variable "instance_type" {
  default = "t2.nano"
}

variable "min_size" {
  default = 1
}

variable "max_size" {
  default = 2
}

variable "desired_capacity" {
  default = 1
}
