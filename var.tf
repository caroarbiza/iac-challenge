/* Vars */
variable "img" {
  description = "The ami of the ec2"
  default = "ami-08e4e35cccc6189f4"
}

variable "key" {
  description = "Key for accesing via SSH"
  default = "CARBIZA-KEY"
}

variable "instance-type" {
  type        = string
  default = "t2.micro"
}