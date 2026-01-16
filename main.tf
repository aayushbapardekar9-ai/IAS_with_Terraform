# 1. Find the latest Amazon Linux 2 image automatically
data "aws_ami" "amazon_linux" {
  most_recent = true
  owners      = ["amazon"]
  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }
}

# 2. Create the Web Server (in Public Subnet)
resource "aws_instance" "web" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.public.id
  
  # Attach the Security Group we made in security.tf
  vpc_security_group_ids = [aws_security_group.web_sg.id]

  # This script runs ONCE when the server starts.
  # It installs Apache and creates a simple webpage.
  user_data = <<-EOF
              #!/bin/bash
              yum update -y
              yum install -y httpd
              systemctl start httpd
              systemctl enable httpd
              echo "<h1>Hello! I was built by Terraform!</h1>" > /var/www/html/index.html
              EOF

  tags = {
    Name = "My-Web-Server"
  }
}

# 3. Create the Database Server (in Private Subnet)
resource "aws_instance" "db" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t3.micro"
  subnet_id     = aws_subnet.private.id
  
  vpc_security_group_ids = [aws_security_group.db_sg.id]

  tags = {
    Name = "My-DB-Server"
  }
}