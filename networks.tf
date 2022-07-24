# Create network resources

# Create 2 VPCS
# Create a VPC in us-east-1
resource "aws_vpc" "vpc_master" {
  provider             = aws.region-master
  cidr_block           = "10.0.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "master-vpc-jenkins"
  }
}

# Create a VPC in us-west-2
resource "aws_vpc" "vpc_master_oregon" {
  provider             = aws.region-worker
  cidr_block           = "192.168.0.0/16"
  enable_dns_support   = true
  enable_dns_hostnames = true
  tags = {
    Name = "worker-vpc-jenkins"
  }
}

# -----------------------------------
# Internet Gateways

# Create IGW us-east-1
resource "aws_internet_gateway" "igw" {
  provider = aws.region-master
  vpc_id   = aws_vpc.vpc_master.id
}

# Create IGW in us-west-2
resource "aws_internet_gateway" "igw-oregon" {
  provider = aws.region-worker
  vpc_id   = aws_vpc.vpc_master_oregon.id
}

# Get all AZ's in VPC for region_master
data "aws_availability_zones" "azs" {
  provider = aws.region-master
  state    = "available"
}

# ----------------------------------------------
# Create Subnets
# ----------------------------------------------

# Create subnet #1 in us-east-1
resource "aws_subnet" "subnet_1" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 0)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.1.0/24"
}

# Create subnet #2 in us-east-1
resource "aws_subnet" "subnet_2" {
  provider          = aws.region-master
  availability_zone = element(data.aws_availability_zones.azs.names, 1)
  vpc_id            = aws_vpc.vpc_master.id
  cidr_block        = "10.0.2.0/24"
}

# Create subnet in us-west-2
resource "aws_subnet" "subnet_1_oregon" {
  provider   = aws.region-worker
  vpc_id     = aws_vpc.vpc_master_oregon.id
  cidr_block = "192.168.1.0/24"
}
