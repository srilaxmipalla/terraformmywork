provider "aws" {
  profile    = "Terraform_User"
  access_key = "AKIAVEDFQVRGM6N7YXF7"
  secret_key = "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"
  region     = "eu-west-2"
}
resource "aws_instance" "linux" {
  ami   = "ami-078a289ddf4b09ae0"
  count = 5
  tags = {
    Name = "linux-instance"
  }
  instance_type   = "t2.micro"
  key_name        = "terraform-london"
  security_groups = ["${aws_security_group.allow_ssh.name}"]
}
resource "aws_security_group" "allow_ssh" {
  tags = {
    Name = "Allow_SSH"
  }
  name        = "allow_ssh"
  description = "allow all ssh traffic"
  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]

  }
}


