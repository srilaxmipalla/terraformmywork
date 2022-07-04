provider "aws" {
  profile    = "Terraform_User"
  access_key = "AKIAVEDFQVRGM6N7YXF7"
  secret_key = "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"
  region     = "eu-west-2"

}
#creating webserver instance using terraform
resource "aws_instance" "webserver" {
  ami = "ami-078a289ddf4b09ae0"
  tags = {
    Name = "linux-webserver"
  }
  instance_type   = "t2.micro"
  key_name        = "terraform-london"
  security_groups = ["${aws_security_group.allow_ssh_httpd.name}"]
  # user data script in aws ec2 instance by using terraform
  user_data = file("script.sh")
}
# creating security group using terraform
resource "aws_security_group" "allow_ssh_httpd" {
  name        = "allow_ssh_http"
  description = "allow all ssh && httpd traffic"
  tags = {
    Name = "ALLOW_SSH_HTTPD"
  }
  ingress {
    description      = "allow ssh from vpc"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    description      = "allow httpd from vpc"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

