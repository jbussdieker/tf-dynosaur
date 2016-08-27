data "aws_ami" "ubuntu" {
  most_recent = true
  filter {
    name   = "owner-id"
    values = ["099720109477"]
  }
  filter {
    name   = "name"
    values = ["ubuntu/images/*${var.release}*"]
  }
  filter {
    name   = "state"
    values = ["available"]
  }
  filter {
    name   = "virtualization-type"
    values = ["${var.virtualization_type}"]
  }
  filter {
    name   = "root-device-type"
    values = ["${var.root_device_type}"]
  }
}
