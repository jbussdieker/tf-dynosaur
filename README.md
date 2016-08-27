# tf-dynosaur

Dynosaur is an instance listening on port 22 for git pushes. Once a push is received it tries each of the default Heroku build packs until a match is found. Next the project is compiled and stared with logs streaming to the git session. If the user ends the session the app will continue to run in the background.

## Usage

````bash
$ terraform apply
$ PUBLIC_IP=$(terraform output instance_public_ips)
$ cd SOME_HEROKU_COMPATIBLE_REPO
$ git push dyno@${PUBLIC_IP}:rails-project
````

## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| vpc_cidr_block | VPC IP block | `"10.0.0.0/16"` | no |
| subnet_cidr_block | Subnet IP block | `"10.0.0.0/24"` | no |
| instance_type | Instance type (m3.medium, c4.large, etc.) | `"m3.medium"` | no |
| release | Ubuntu Release (precise, trusty, xenial, etc.) | `"trusty"` | no |
| virtualization_type | Virtualization type (hvm or paravirtual) | `"hvm"` | no |
| root_device_type | Root volume type (instance-store or ebs) | `"instance-store"` | no |
| instance_count | Number of instances to launch | `0` | no |
| key_name | Name of AWS keypair | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| image_name | AMI image name |
| image_id | AMI image ID |
| instance_ids | List of instance IDs |
| instance_private_ips | List of instance private IPs |
| instance_public_ips | List of instance public IPs |
