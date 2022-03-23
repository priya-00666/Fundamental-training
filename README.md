# Cloudify Training Labs
You will be given a lab token which you can use to spin-up your training lab environment. It will take approximate five minutes for all resources to be created, configured and become available. 

The lab will be configured to run for a set duration. If you finish earlier, please stop the lab so that resources can be deleted. 

You will be able to launch addition lab sessions. Please note that your work will not be saved between sessions. Be sure to save a local copy of anything you want to keep.

## Lab Environment

The lab environment will include the following resources:

* Lab Dashboard - where you can find IPs and credentials for all lab resources
* Cloudify Manager version 6.3.1
* CLI VM - you can install the CFY CLI on this VM
* (3) Pre-created Application VMs for use in blueprints
* OpenStack 

## Secrets Setup

Your CFY Manager will be pre-configured with the following secrets:

* `openstack credentials`
* `lab exercise secrets`

## Installing the CLI
1. SSH to the CLI VM (Training VM user: centos; Training VMs Private Key: found on Lab Dashboard)
2. Install the RPM   
`sudo yum install http://repository.cloudifysource.org/cloudify/6.3.1/ga-release/cloudify-cli-6.3.1-ga.el7.x86_64.rpm`
3. Connect the CLI to your manager. [CLI documentation](https://docs.cloudify.co/latest/cli/maint_cli/profiles/).  
`cfy profiles use <MANAGER_IP> -u <USER> -p <PASSWORD> -t default_tenant`


## Lab Exercise Respository
You you will need to clone this repository to your CLI VM.
1. SSH to the CLI VM (Training VM user: centos; Training VMs Private Key: found on Lab Dashboard)
2. Install git.  
`sudo yum install git -y`
3. `git clone -b 631 https://github.com/Cloudify-PS/fundamentals-training.git`
## Uploading Blueprints

The quickest way to upload blueprints to a Cloudify manager is with the command line via the `cfy blueprint upload` command. This should be executed from within the directory containing the blueprint.

Note, you can upload multiple copies of a blueprint file, but each copy will need to have a unique blueprint id.

For example, the following command uploads the basic.yaml blueprint to the Cloudify manager, and gives it a blueprint id of `basic`:

```
>$ pwd
/home/centos/fundamentals-training
[>$ cfy blueprints upload -b basic basic.yaml
Uploading blueprint basic.yaml...
 basic.yaml |##########################################################| 100.0%
Blueprint `basic` upload started.
2022-03-23 16:31:07.492  CFY <None> Starting 'upload_blueprint' workflow execution
2022-03-23 16:31:07.562  LOG <None> INFO: Blueprint archive uploaded. Extracting...
2022-03-23 16:31:07.646  LOG <None> INFO: Blueprint archive extracted. Parsing...
2022-03-23 16:31:08.435  LOG <None> INFO: Blueprint parsed. Updating DB with blueprint plan.
2022-03-23 16:31:08.600  CFY <None> 'upload_blueprint' workflow execution succeeded
Blueprint uploaded. The blueprint's id is basic
>$
```

Blueprints can also be uploaded via the UI, but they should be zipped first. For example, the following command will zip up the lab blueprints so that they can be uploaded via the UI. Notice that the `zip` is executed from **one directory above** the directory containing the blueprints.

```
>$ pwd
/home/centos
>$ ls
fundamentals-training
>$ zip -r fundamentals-training.zip fundamentals-training/ -x 'fundamentals-training/.git/*'
  adding: fundamentals-training/ (stored 0%)
  adding: fundamentals-training/blueprint-osp-vm-full-dp.yaml (deflated 75%)
  adding: fundamentals-training/blueprint-osp-vm-full.yaml (deflated 75%)
  adding: fundamentals-training/blueprint-osp-vm-solution.yaml (deflated 78%)
  adding: fundamentals-training/blueprint-osp-vm.yaml (deflated 73%)
  adding: fundamentals-training/openstack-example-network.yaml (deflated 80%)
  adding: fundamentals-training/openstack-example-network.yaml~ (deflated 80%)
  adding: fundamentals-training/openstack-vm-blueprint-ws.yaml (deflated 76%)
  adding: fundamentals-training/resources/ (stored 0%)
  adding: fundamentals-training/resources/index.html (deflated 39%)
  adding: fundamentals-training/scripts/ (stored 0%)
  adding: fundamentals-training/scripts/basic/ (stored 0%)
...
```

# Blueprints

