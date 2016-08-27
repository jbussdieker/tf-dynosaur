# tf-dynosaur

Dynosaur is an instance listening on port 22 for git pushes. Once a push is received it tries each of the default [Heroku build packs](https://devcenter.heroku.com/articles/buildpacks) until a match is found. Next the project is compiled and stared with logs streaming to the git session. If the user ends the session the app will continue to run in the background.

## Usage

````bash
$ terraform apply
$ PUBLIC_IP=$(terraform output instance_public_ips)
$ cd SOME_HEROKU_COMPATIBLE_REPO
$ git push dyno@${PUBLIC_IP}:rails-project
Writing objects: 100% (64/64), 17.35 KiB | 0 bytes/s, done.
Total 64 (delta 2), reused 0 (delta 0)
remote: Building rails-project
remote: -----> Ruby app detected
remote: -----> Compiling Ruby/Rails
...
remote: 12:32:05 web.1     | => Booting WEBrick
remote: 12:32:05 web.1     | => Rails 4.1.4 application starting in production on http://0.0.0.0:5200
remote: 12:32:05 web.1     | => Run `rails server -h` for more startup options
remote: 12:32:05 web.1     | => Notice: server is listening on all interfaces (0.0.0.0). Consider using 127.0.0.1 (--binding option)
remote: 12:32:05 web.1     | => Ctrl-C to shutdown server
````

````
$ ssh dyno@52.53.210.153
Welcome to Dynosaur!

Commands:
  check
  console
  rake ARGS
````

## Supported Build Packs

 * https://github.com/heroku/heroku-buildpack-ruby
 * https://github.com/heroku/heroku-buildpack-nodejs
 * https://github.com/heroku/heroku-buildpack-closure
 * https://github.com/heroku/heroku-buildpack-python
 * https://github.com/heroku/heroku-buildpack-java
 * https://github.com/heroku/heroku-buildpack-gradle
 * https://github.com/heroku/heroku-buildpack-grails
 * https://github.com/heroku/heroku-buildpack-scala
 * https://github.com/heroku/heroku-buildpack-play
 * https://github.com/heroku/heroku-buildpack-php
 * https://github.com/heroku/heroku-buildpack-go

## Inputs

| Name | Description | Default | Required |
|------|-------------|:-----:|:-----:|
| vpc_cidr_block | VPC IP block | `"10.0.0.0/16"` | no |
| subnet_cidr_block | Subnet IP block | `"10.0.0.0/24"` | no |
| instance_type | Instance type (m3.medium, c4.large, etc.) | `"m3.medium"` | no |
| release | Ubuntu Release (precise, trusty, xenial, etc.) | `"trusty"` | no |
| virtualization_type | Virtualization type (hvm or paravirtual) | `"hvm"` | no |
| root_device_type | Root volume type (instance-store or ebs) | `"instance-store"` | no |
| instance_count | Number of instances to launch | `1` | no |
| key_name | Name of AWS keypair | - | yes |

## Outputs

| Name | Description |
|------|-------------|
| image_name | AMI image name |
| image_id | AMI image ID |
| instance_ids | List of instance IDs |
| instance_private_ips | List of instance private IPs |
| instance_public_ips | List of instance public IPs |
