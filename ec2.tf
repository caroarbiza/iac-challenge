module "ec2_instance" {
  source  = "terraform-aws-modules/ec2-instance/aws"
  version = "~> 3.0"

  name = "iac-instance"

  ami                    = var.img
  instance_type          = var.instance-type
  key_name               = var.key
  vpc_security_group_ids = [aws_security_group.allow_ssh_http.id]
  subnet_id              = aws_subnet.public_subnet_iac.id
  user_data = templatefile("./user_data.tftpl",{})

}

output "instance_public_ip" {
  value = "${module.ec2_instance.public_ip}"
}