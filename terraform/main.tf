terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.82.2"
    }
  }
}

//Setting Credentials
provider "aws" {
  region     = "us-east-1"
}

// Create VPC
resource "aws_vpc" "demo-vpc" {
  cidr_block       = "20.2.0.0/16"
  instance_tenancy = "default"
  enable_dns_support = true
  enable_dns_hostnames = true
  tags = {
    Name = "lks-kabbanyumas-25"
  }
}
// Required Ipv6

resource "aws_vpc_ipam" "ipv6" {
  operating_regions {
    region_name = "us-east-1" # Sesuaikan dengan region Anda
  }
}

// Create Public Subnet
resource "aws_subnet" "public-subnet1" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "20.2.0.0/24"
  availability_zone = "us-east-1a"

  tags = {
    Name = "lks-public-subnet1"
  }
}

resource "aws_subnet" "public-subnet2" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "20.2.1.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "lks-public-subnet2"
  }
}


// Create Private Subnet
resource "aws_subnet" "private-subnet1" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "20.2.2.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "lks-privat-subnet1"
  }
}
// Create Public Subnet
resource "aws_subnet" "private-subnet2" {
  vpc_id     = aws_vpc.demo-vpc.id
  cidr_block = "20.2.3.0/24"
  availability_zone = "us-east-1b"

  tags = {
    Name = "lks-private-subnet2"
  }
}

//Create Internet Gateway
resource "aws_internet_gateway" "lks-igw" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "lks-internetgateway"
  }
}

//Route Table
resource "aws_route_table" "lks-rtb" {
  vpc_id = aws_vpc.demo-vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.lks-igw.id
  }

  tags = {
    Name = "lks-publicroute"
  }
}

//Subnet Association Public
resource "aws_route_table_association" "demo-subnetassc" {
  subnet_id      = aws_subnet.public-subnet1.id
  route_table_id = aws_route_table.lks-rtb.id
}
//Subnet Association Public
resource "aws_route_table_association" "demo-subnetassc2" {
  subnet_id      = aws_subnet.public-subnet2.id
  route_table_id = aws_route_table.lks-rtb.id
}

//security group
resource "aws_security_group" "sg-lb" {
  name        = "SgLb"
  description = "Security Group For Alb"
  vpc_id      = aws_vpc.demo-vpc.id

tags = {
    Name = "sg-lb"
  }


 ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

//security group
resource "aws_security_group" "sg-apps" {
  name        = "SgApps"
  description = "Security Group For Alb"
  vpc_id      = aws_vpc.demo-vpc.id

tags = {
    Name = "sg-apps"
  }


 ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
 ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
  ingress {
    from_port   = 5000
    to_port     = 5000
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }
}

//nat instance
resource "aws_instance" "nat_instance" {
  ami           = "ami-00a929b66ed6e0de6" 
  instance_type = "t2.micro"
  subnet_id     = aws_subnet.public-subnet1.id
  key_name      = "vockey"  
  security_groups = [
    aws_security_group.sg-lb.id
  ]
  associate_public_ip_address = true
  # Nonaktifkan pemeriksaan source/destination agar NAT dapat meneruskan trafik
  source_dest_check = false

  user_data = <<-EOF
                #!/bin/bash
                sudo yum update
                sudo yum install iptables-services -y
                sudo systemctl enable iptables
                sudo systemctl start iptables
                sudo echo net.ipv4.ip_forward=1 >> /etc/sysctl.d/custom-ip-forwarding.conf
                sudo sysctl -p /etc/sysctl.d/custom-ip-forwarding.conf
                sudo /sbin/iptables -t nat -A POSTROUTING -o eth0 -j MASQUERADE
                sudo /sbin/iptables -F FORWARD
                sudo service iptables save
                EOF

    tags = {
        Name = "NAT-Instance"
  }
}

resource "aws_route_table" "private_rt" {
  vpc_id = aws_vpc.demo-vpc.id

  tags = {
    Name = "PrivateRouteTable"
  }
}


//Subnet Association Public
resource "aws_route_table_association" "subnet-ass-private1" {
  subnet_id      = aws_subnet.private-subnet1.id
  route_table_id = aws_route_table.private_rt.id
}
//Subnet Association Public
resource "aws_route_table_association" "subnet-ass-private2" {
  subnet_id      = aws_subnet.private-subnet2.id
  route_table_id = aws_route_table.private_rt.id
}


//S3
resource "aws_s3_bucket" "" {
  bucket = "lks-kabbanyumas-jeremi-25"

  tags = {
    Name        = "My bucket"
    Environment = "Dev"
  }
}