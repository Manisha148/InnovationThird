# EC2 Instance
resource "aws_instance" "example" {
  ami           = "ami-0c55b159cbfafe1f0"
  instance_type = "t2.micro"
  tags = {
    Name = "example"
  }
}

# S3 Bucket
resource "aws_s3_bucket" "example" {
  bucket = "example-bucket"
  acl    = "private"

  tags = {
    Name = "example"
  }
}

# VPC
resource "aws_vpc" "example" {
  cidr_block = "10.0.0.0/16"

  tags = {
    Name = "example"
  }
}

# Security Group
resource "aws_security_group" "example" {
  name_prefix = "example-sg"
  vpc_id      = aws_vpc.example.id

  ingress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 65535
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "example"
  }
}

# Buildspec file for AWS CodePipeline
resource "aws_codebuild_project" "example" {
  name          = "example-project"
  description   = "Example CodeBuild project"
  build_timeout = 60

  environment {
    compute_type = "BUILD_GENERAL1_SMALL"
    image        = "aws/codebuild/standard:5.0"
    type         = "LINUX_CONTAINER"
  }

  artifacts {
    type = "CODEPIPELINE"
  }

  source {
    type            = "CODEPIPELINE"
    buildspec       = file("buildspec.yml")
    report_build_status = true
  }
}
