resource "aws_vpc" "main" {
  cidr_block = "192.168.0.0/22"
}

resource "aws_vpc" "dev" {
  cidr_block = "192.168.0.0/20"

  tags = {
    name = "development"
    Name = "dev_vpc"
  }
}

resource "aws_instance" "main" {
  ami           = "ami-0fc5d935ebf8bc3bc"
  instance_type = "t2.micro"
  tags = {
    Name = "YourVM"

  }
}


data "aws_ami" "main" {
  most_recent = true
  owners      = ["099720109477"]
  filter {
    name   = "name"
    values = ["ubuntu/images/hvm-ssd/ubuntu-*-22.04-amd64-server*"]
  }

}

data "aws_vpc" "main" {
  default = true
}


resource "aws_subnet" "main" {
  cidr_block = "172.31.96.0/20"
  vpc_id     = data.aws_vpc.main.id
  map_public_ip_on_launch = true
}

resource "aws_instance" "Web" {
  ami           = data.aws_ami.main.id
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.main.id
  tags = {
    Name = "WebServer"
  }

}

output "default_vpc_id" {
  value = data.aws_vpc.main.id
}

output "my_amd_id_is" {
  value = data.aws_ami.main.id
  
}


output "value_of_instance_ip" {
  value = aws_instance.main.public_ip
}  
