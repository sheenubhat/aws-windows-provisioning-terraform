
provider "aws" {
    region = var.region
}

resource "tls_private_key""generated_key"  {
    algorithm = "RSA"
    rsa_bits = 4096
}

resource "aws_key_pair""deployed_key"  {
    key_name = var.key_name
    public_key = tls_private_key.generated_key.public_key_openssh
}

resource "local_file""private_key"  {
    content = tls_private_key.generated_key.private_key_pem
    filename = "${vara.key_name}.pem"
}

resource "aws_security_group" "allow_rdp" {
        name = "allow_rdp"
        description = "Allow RDP access"
        vpc_id = var.vpc_id

        ingress {
            from_port = 3389
            to_port = 3389
            protocol = "tcp"
            cidr_blocks = ["0.0.0.0/0"]
        }

        egress {
            from_port = 0
            to_port = 0
            protocol = "tcp"
            cidr_blocks =["0.0.0.0/0"]
        }
    }

//fetch AMI 
data "aws_ami" "WindowsAmi"{
    most_recent = true
    //owners = []
    filter {
        name = "name"
        values = ["windows-2016-*"]
    }
}

resource "aws_instance" "Windows" {
    ami = data.aws_ami.WindowsAmi.id
    instance_type = var.instance_type
    subnet_id = var.subnet_id
    key_name = aws_key_pair.deployed_key.key_name
    vpc_security_group_ids = [var.sg_id]

    user_data = file("installApps.ps1")


    metadata_options {
      http_endpoint = "enabled"
      http_tokens = "required"
      http_put_response_hop_limit = 1
    }

    tags = {
      Name = "AmazonWindow"
      //data_class =
      //cmdb
    }

    //encrypted EBS volume
    root_block_device {
      volume_type = "gp3"
      volume_size = 200
      encrypted = true
      delete_on_termination = true

      tags = {
        Name = "ebs"
      }
    }
} 

//EBS data volume )persistant storage
resource "aws_ebs_volume""data_disk" {
    availability_zone = var.availability_zone
    size = 200
    type = "gp3"
    encrypted = true

    tags = {
        device_name = "xvdf"
    }
    
}