resource "aws_security_group" "efs_sg" {
  vpc_id      = aws_vpc.vpc-01.id
  
    ingress {
    from_port   = 2049
    to_port     = 2049
    protocol    = "tcp"
    cidr_blocks = [aws_vpc.vpc-01.cidr_block]  # Allow traffic within the VPC
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  tags = {
    Name = "ec2_security_group"
    Environment = "${var.environment}"
  }
}
