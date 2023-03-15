# Cloudify Training Labs
### Prerequisites:
* [Cloudify Getting Started Course](https://partners.cloudify.co/)
* Ability to install Cloudify (VM, Kubernetes cluster, Docker)
* Cloudify license (request a trial here: https://cloudify.co/download/)

## Installation/Setup of Cloudify Manager

These exercises are designed to be used with any Cloudify manager (current version). It's strongly recommended to install/configure and use a temporary manager for training purposes.

<b>Cloudify supports the following installation methods:</b>
* [CentOS/ RHEL](https://docs.cloudify.co/latest/cloudify_manager/premium/aio/install_and_configure/centos_rhel/)
* [Docker Container](https://docs.cloudify.co/latest/cloudify_manager/premium/aio/install_and_configure/docker/)
* [Helm Chart](https://docs.cloudify.co/latest/cloudify_manager/premium/aio/install_and_configure/helm/)
* [AWS AMI](https://docs.cloudify.co/latest/cloudify_manager/premium/aio/install_and_configure/aws/)
* [QCOW2](https://docs.cloudify.co/latest/cloudify_manager/premium/aio/install_and_configure/image/)
* [SaaS](https://docs.cloudify.co/latest/cloudify_manager/saas/)

A Cloudify AIO (All In One) Manager installed with the minimum required resources will be sufficient to complete the exercises. Please see the full [installation prerequisites](https://docs.cloudify.co/latest/cloudify_manager/premium/aio/capacity_and_planning/) and [networking requirements](https://docs.cloudify.co/latest/cloudify_manager/architecture/high_level_architecture/networking/).

<b>Centos/RHEL RPM-based AIO Cloudify Manager installation:</b>
1. SSH to your VM
2. `$ sudo yum install RPM` (link provided by instructor)
3. `$ cfy_manager install --private-ip VM-PRIVATE_IP --public-ip VM-PUBLIC_IP --admin-password STRONG-PASSWORD`
4. Check that the manager is healthy from the VM command line: `$ cfy status`

<b>Cloudify Manager Docker Image</b>
1. `docker run -p 80:80 -d cloudifyplatform/premium-cloudify-manager-aio:latest`
2. Check that the manager is healthy from the container command line: `$ cfy status`

<b>Default admin user password</b>
The default `admin` user password is `admin`. You can reset the admin user password from the command line:
`$ cfy_manager reset-admin-password MY-NEW-PASSWORD`

<b>Add the license file </b>
The license can be added via the [UI or the CLI](https://docs.cloudify.co/latest/cloudify_manager/premium/compact/install_and_configure/activate/).
`cfy license upload license.yaml`


## Installing the Cloudify CLI

The CLI installation is optional. For a privately installed manager intended for training purposes, you may work directly on the manager using the builtin CLI. However, for a shared manager, it's recommended to have a separate CLI installation.

<b>Install Centos/RHEL RPM-based Cloudify CLI</b>
1. SSH to the CLI VM
2. Install the RPM   
`sudo yum install http://repository.cloudifysource.org/cloudify/6.4.1/ga-release/cloudify-cli-6.4.1-ga.el7.x86_64.rpm`
3. Connect the CLI to your manager. [cfy profiles documentation](https://docs.cloudify.co/latest/cli/maint_cli/profiles/).  
`cfy profiles use <MANAGER_IP> -u <USER> -p <PASSWORD> -t default_tenant`
4. Check out the CLI help.  
`cfy -h`

<b>Or install the CLI on locally on MacOS:</b>
1. `curl -sfL https://cloudify.co/get-cli | sh -`
2. Connect the CLI to your manager. [cfy profiles documentation](https://docs.cloudify.co/latest/cli/maint_cli/profiles/).  
`cfy profiles use <MANAGER_IP> -u <USER> -p <PASSWORD> -t default_tenant`
3. Check out the CLI help.  
`cfy -h`
[CLI Installation Documentation](https://docs.cloudify.co/latest/cloudify_manager/cloudify_cli/)

## Lab Exercise Respository
These training exercises are meant to be used alongside Cloudify Getting Started Training. You you will need to clone this repository to your CLI environment. Note the branch `641`
1. SSH to the CLI VM or local installation
2. Install git.  
`sudo yum install git -y` (or as needed for your local environment)
3. `git clone -b 641 https://github.com/Cloudify-PS/fundamentals-training.git`

## Manager Walk Through

Here's a video that will introduce you to the Cloudify UI. [Manager Walk Through Video](https://www.youtube.com/watch?v=R6SmO4qfILE&t=2s)

## Lab Exercises
* [Lab 1 - Hello World](lab1/README.md)
* [Lab 2 - Blueprints](lab2/README.md)
* [Lab 3 - Service Composition](lab3/README.md)
* [Lab 4 - Operations](lab4/README.md)

## Next steps

After completing Labs 1-4 you should be able to:

* Add your cloud provider credentials to your manager
* Upload and deploy catalog blueprints (directly from the dashboard) or [community blueprints](https://github.com/cloudify-community/blueprint-examples)  
