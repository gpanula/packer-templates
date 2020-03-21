# packer-templates
Templates for packer jobs

Current jobs:

- Create a CentOS 7 image with Mainline kernel on AWS
- Create a CentOS 8 image on AWS using a mainline CentOS 7 EBS surrogate

Either execute the json template directly or just use `make`.

## Notes

- The CentOS 8 template should filter on your AWS Account ID to make sure nobody can inject an AMI into your buid process, example is commented in
- The packer jobs expect AWS credentials to be available in the environment, and by default it will assign a public IP and create a temporary SG to access the EC2 instance