# PoC TeamCity infra based on VMs
This repository contains PoC infrastructure for TeamCity with agents running on Ubuntu Server 20.04 and Windows Server 
2019. TeamCity runs within Docker containers with makes VMs more flexible and easier to maintain. From the top to 
bottom, all configuration and automation use code-first approach and well known tooling like Terraform, Ansible
and Packer.
      
## Challenges with the initial idea
The initial idea was to keep Ansible playbooks inside the VMs to make them more self-contained. Such approach helps
with auditing the configuration (because everything is always there) or applying changes in on-premisses, air-gaped 
environments. While general overview on Ansible documentation says it can be used with Windows nodes, well, it is
not that easy. Management of Windows nodes can be only done from POSIX OSes because Ansible simply does not
run on Windows. Things get a bit more complicated also because Ansible uses WinRM protocol in communication with Windows
machines. It cannot be easily tunneled with Ansible's built-in mechanisms while connecting through bastion host. What
is more, there was also Packer, that had a different set of connection issues.

At the end, here it is. With Ansible running outside the VMs, but still pretty much covering the concept.

## Repository structure:
- `prerequisites` - Terraform configuration providing AWS resources required by VM import and infrastructure 
  provisioning processes. It creates S3 bucket and policy used by OVA VM image conversion to AMI, and also separate S3 
  bucket for infrastructure state.
- `virtualmachines` - Packer and Ansible based automation to create and configure VM images based on Ubuntu Server 20.04
  and Windows Server 2019. Both images include Docker engine that allows to run TeamCity server and agents all together.
- `infrastructure` - Terraform configuration providing infrastructure to run TeamCity server with agents on both
  platforms. It includes offloading encrypted traffic on ALB, storing DB data within RDS and files in EFS. Access to
  internal network requires jumping through bastion host.

## Dependencies:
- make
- ssh-agent (-like program)
- virtualbox 6.1.22+
- ansible 2.11.2+
- packer 1.7.3+
- terraform 1.0.2+

## Tested on:
- MacOS Big Sur 11.4

## Getting started

### Configure local variables for Packer
In `virtualmachines` directory, copy `local.pkrvars.hcl.example` to `local.pkrvars.hcl` and fill the missing values.

### Configure local variables for Terraform
In `infrastructure` directory, copy `local.tfvars` to `local.tfvars` and fill the missing values.

### Configure AWS profile that will be used in further steps
```shell
export `AWS_PROFILE=...`
````

### Execute all in one Makefile target
```shell
make all
```

### DNS zone delegation
During infrastructure creation, Terraform will pause on SSL/TLS certificate validation on ACM side. This process
requires DNS zone delegation to be properly attached to the parent domain with NS records. While Terraform will be
still applying changes, please navigate to Route 53 section in AWS Console and check what addresses should be used
manually.

## Some TODOs:
- General security hardening in VMs (removing defaults, default and sudo password, networking, etc.)
- More complete HA setup  
- Docker resource limits for containers
- Agents could have different configs
- Pass container logs to CloudWatch
- Cleanup VM images before exporting (reduce size)
- I forgot how slow EFS is...
