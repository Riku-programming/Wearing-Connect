variable "vpc_id" {
  default = ""
}
resource "aws_security_group" "sg" {
  name = "sg"
  vpc_id = var.vpc_id

  ingress {
    from_port = 80
    protocol = "tcp"
    to_port = 80
  }
  egress {
    from_port = 0
    protocol = "-1"
    to_port = 0
    cidr_blocks = [
      "0.0.0.0/0",
    ]
  }
}