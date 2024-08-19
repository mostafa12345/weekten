resource "aws_subnet" "subnet-1" {
  vpc_id     = aws_vpc.vpc-01.id
  cidr_block = var.dev_subnet1_cidr_block
  availability_zone = "us-east-1b"

  tags = {
    Name = "subnet-1"
    Environment = "${var.environment}"
  }
}

resource "aws_internet_gateway" "gw-01" {
  vpc_id = aws_vpc.vpc-01.id

  tags = {
    Name = "gw-01"
    Environment = "${var.environment}"
  }
}

