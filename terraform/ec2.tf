variable "security_group_ids" {
  default = ""
}
variable "subnet_id" {
  default = ""
}
variable "ami" {
  default = ""
}
resource "aws_instance" "ec2" {
  ami = var.ami
  instance_type = "t2.micro"
  monitoring = false
  subnet_id = var.subnet_id
  vpc_security_group_ids = var.security_group_ids
  tags = {
    Name = "Riku_instance"
  }
}