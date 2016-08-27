resource "aws_vpc" "main" {
  count                = "${signum(var.instance_count)}"
  enable_dns_hostnames = true
  cidr_block           = "${var.vpc_cidr_block}"
}

resource "aws_internet_gateway" "main" {
  count  = "${signum(var.instance_count)}"
  vpc_id = "${aws_vpc.main.id}"
}

resource "aws_route" "internet" {
  count                  = "${signum(var.instance_count)}"
  route_table_id         = "${aws_vpc.main.main_route_table_id}"
  destination_cidr_block = "0.0.0.0/0"
  gateway_id             = "${aws_internet_gateway.main.id}"
}

resource "aws_subnet" "main" {
  count                   = "${signum(var.instance_count)}"
  vpc_id                  = "${aws_vpc.main.id}"
  cidr_block              = "${var.subnet_cidr_block}"
  map_public_ip_on_launch = true
}

resource "aws_security_group_rule" "allow_ssh" {
  count             = "${signum(var.instance_count)}"
  type              = "ingress"
  from_port         = 22
  to_port           = 22
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_vpc.main.default_security_group_id}"
}

resource "aws_security_group_rule" "allow_web" {
  count             = "${signum(var.instance_count)}"
  type              = "ingress"
  from_port         = 5200
  to_port           = 5200
  protocol          = "tcp"
  cidr_blocks       = ["0.0.0.0/0"]
  security_group_id = "${aws_vpc.main.default_security_group_id}"
}

resource "aws_instance" "instance" {
  count         = "${var.instance_count}"
  instance_type = "${var.instance_type}"
  ami           = "${data.aws_ami.ubuntu.id}"
  subnet_id     = "${aws_subnet.main.id}"
  key_name      = "${var.key_name}"
  user_data     = "${file("bootstrap.sh")}"
}
