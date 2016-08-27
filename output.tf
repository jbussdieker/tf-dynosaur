// AMI image name
output "image_name" {
  value = "${data.aws_ami.ubuntu.name}"
}

// AMI image ID
output "image_id" {
  value = "${data.aws_ami.ubuntu.id}"
}

// List of instance IDs
output "instance_ids" {
  value = ["${aws_instance.instance.*.id}"]
}

// List of instance private IPs
output "instance_private_ips" {
  value = ["${aws_instance.instance.*.private_ip}"]
}

// List of instance public IPs
output "instance_public_ips" {
  value = ["${aws_instance.instance.*.public_ip}"]
}
