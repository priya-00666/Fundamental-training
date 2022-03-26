# Cloudify Training Labs
### Prerequisites:
* Clouidify Fundamentals Training
* Clouidfy Lab Environment token 

You will be given a lab token which you can use to spin-up your training lab environment. It will take approximately five minutes for all resources to be created, configured and become available. 

The lab will be configured to run for a set duration. If you finish earlier, please stop the lab so that resources can be deleted. 

You will be able to launch addition lab sessions. Please note that your <b>work will not be saved</b> between sessions. Be sure to save a local copy of anything you want to keep.

## Lab Environment

The lab environment will include the following resources:

* Lab Dashboard - where you can find IPs and credentials for all lab resources
* Cloudify Manager version 6.3.1
* CLI VM - you can install the CFY CLI on this VM
* (3) Pre-created Application VMs for use in blueprints
* OpenStack 

## Secrets Setup

Your CFY Manager will be pre-configured with the following secrets:

* `OpenStack credentials`
* `lab exercise secrets`

Please see [Secrets documentation](https://docs.cloudify.co/latest/cli/orch_cli/secrets/) for more information. 

## Installing the CLI
1. SSH to the CLI VM (Training VM user: centos; Training VMs Private Key: found on Lab Dashboard)
2. Install the RPM   
`sudo yum install http://repository.cloudifysource.org/cloudify/6.3.1/ga-release/cloudify-cli-6.3.1-ga.el7.x86_64.rpm`
3. Connect the CLI to your manager. [CLI documentation](https://docs.cloudify.co/latest/cli/maint_cli/profiles/).  
`cfy profiles use <MANAGER_IP> -u <USER> -p <PASSWORD> -t default_tenant`
4. Check out the CLI help.  
`cfy -h`


## Lab Exercise Respository
These training exercises are meant to be used alongside Cloudify Fundamentals Training. You you will need to clone this repository to your CLI VM.
1. SSH to the CLI VM (Training VM user: centos; Training VMs Private Key: found on Lab Dashboard)
2. Install git.  
`sudo yum install git -y`
3. `git clone -b 631 https://github.com/Cloudify-PS/fundamentals-training.git`

## Manager Walk Through

Here's a video that will introduce you to the Cloudify dashboard. [Manager Walk Through Video](https://www.youtube.com/watch?v=R6SmO4qfILE&t=2s)

## Lab Exercises
* [Lab 1](lab1/README.md)
