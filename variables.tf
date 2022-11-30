variable "key_name" {
    description = " SSH keys to connect to ec2 instance"
    default     =  "Lota_KP"
}

variable "instance_type" {
    description = "instance type for ec2"
    default     =  "t2.micro"
}

variable "security_group" {
    description = "Name of security group"
    default     = "Test-sec-group.id"
}


variable "tag_name" {
    description = "Tag Name of for Ec2 instance"
    default     = "my-ec2-instance"
}

variable "ami_id" {
    description = "AMI for Ubuntu Ec2 instance"
    default     = "ami-0f540e9f488cfa27d"
}

variable "vpc_id" {
    description = "VPC name"
    default     = "aws_vpc.Prod-rock-VPC.id"
}

variable "region" {
  default = "eu-west-2"
  description = "AWS Region"
}

variable "cidr_block" {
  default = "10.0.0.0/16"
  description = "VPC Cidr"
}

variable "test-public-sub1-cidr_block" {
  default = "10.0.1.0/24"
  description = "test-public-sub1 cidr"
}

variable "test-public-sub2-cidr_block" {
  default = "10.0.2.0/24"
  description = "test-public-sub2 cidr"
}

variable "test-priv-sub1-cidr_block" {
  default = "10.0.3.0/24"
  description = "test-priv-sub1 Cidr"
}

variable "test-priv-sub2-cidr_block" {
  default = "10.0.4.0/24"
  description = "test-priv-sub2 Cidr"
}