## Lab 2 Objectives
In this lab you will learn about:
* Editing YAML
* Editing an existing blueprint
* Creating a secret using the Cloudify UI
* Using the `cfy install` command
* Using the `cfy uninstall` command
* Uploading a plugin
* Modifying and extending blueprints


## References for this lab: 
* [UI documenation - secrets](https://docs.cloudify.co/latest/working_with/console/pages/secrets-page/)
* [UI documenation - plugins](https://docs.cloudify.co/latest/working_with/console/widgets/plugins/)
* [CLI documentation - cfy install](https://docs.cloudify.co/latest/cli/orch_cli/install/)
* [CLI documenation - cfy uninstall](https://docs.cloudify.co/latest/cli/orch_cli/uninstall/)
* [Blueprints - Node templates](https://docs.cloudify.co/latest/developer/blueprints/spec-node-templates/)
* [Blueprints - Relationships](https://docs.cloudify.co/latest/developer/blueprints/spec-relationships/)

## Getting Started
Create and start your lab environment: 
1. Connect to the VPN (optional)
2. Install the CLI on the CLI VM 
3. After each lab clean the system - delete deployment and blueprints

### Part 1 - YAML drill
1. Create a YAML file that contains the following elements and validate it:
* dictionary with 2 keys: hostnames and content
* The key `hostnames` value is a list of: `app, data and proxy`
* The key `content` value is a list of: `node.js, mysql and nginx` 
* Find an online [YAML validator](http://www.yamllint.com/) and validate your file.

### Part 2 - Modifying a basic blueprint
1. SSH to your training CLI VM
2. Clone this repository
3. Using the UI, create a new secret "training_agent_key_private" 
(key file is found on the Lab Dashboard) 
3. Edit the blueprint file `basic.yaml`
Replace the string `REPLACE_WITH_IP_ADDRESS` with your <b>App1 VM IP</b>
(Found on the Lab Dashboard)
4. You can use the `cfy install` command to:
* upload the blueprint
* create the deployment
* execute the install workflow

The `cfy install` command is a very useful shortcut during blueprint development.
```
cfy install -b basic -d basic basic.yaml
Uploading blueprint basic.yaml...
 basic.yaml |##########################################################| 100.0%
Blueprint `basic` upload started.
2022-04-05 02:42:41.823  CFY <None> Starting 'upload_blueprint' workflow execution
2022-04-05 02:42:41.889  LOG <None> INFO: Blueprint archive uploaded. Extracting...
2022-04-05 02:42:41.987  LOG <None> INFO: Blueprint archive extracted. Parsing...
2022-04-05 02:42:42.865  LOG <None> INFO: Blueprint parsed. Updating DB with blueprint plan.
2022-04-05 02:42:43.082  CFY <None> 'upload_blueprint' workflow execution succeeded
Blueprint uploaded. The blueprint's id is basic
Creating new deployment from blueprint basic...
Deployment `basic` created. The deployment's id is basic
Executing workflow `install` on deployment `basic` [timeout=900 seconds]
2022-04-05 02:42:48.609  CFY <basic> Starting 'install' workflow execution
2022-04-05 02:42:48.790  CFY <basic> Subgraph started 'install_my_host_28du44'
2022-04-05 02:42:48.852  CFY <basic> [my_host_28du44] Validating node instance before creation: nothing to do
2022-04-05 02:42:48.879  CFY <basic> [my_host_28du44] Precreating node instance: nothing to do
2022-04-05 02:42:48.905  CFY <basic> [my_host_28du44] Creating node instance: nothing to do
2022-04-05 02:42:48.930  CFY <basic> [my_host_28du44] Configuring node instance: nothing to do
2022-04-05 02:42:48.957  CFY <basic> [my_host_28du44] Starting node instance: nothing to do
2022-04-05 02:42:48.983  CFY <basic> [my_host_28du44] Creating agent
2022-04-05 02:42:49.008  CFY <basic> [my_host_28du44.create] Sending task 'cloudify_agent.installer.operations.create'
2022-04-05 02:42:49.258  CFY <basic> [my_host_28du44.create] Task started 'cloudify_agent.installer.operations.create'
2022-04-05 02:42:51.532  LOG <basic> [my_host_28du44.create] INFO: Creating Agent my_host_28du44
2022-04-05 02:42:55.301  LOG <basic> [my_host_28du44.create] INFO: Agent created, configured and started successfully
2022-04-05 02:42:55.622  CFY <basic> [my_host_28du44.create] Task succeeded 'cloudify_agent.installer.operations.create'
2022-04-05 02:42:55.649  CFY <basic> [my_host_28du44] Agent created
2022-04-05 02:42:55.675  CFY <basic> [my_host_28du44] Poststarting node instance: nothing to do
2022-04-05 02:42:55.714  CFY <basic> [my_host_28du44] Node instance started
2022-04-05 02:42:55.750  CFY <basic> Subgraph succeeded 'install_my_host_28du44'
2022-04-05 02:42:55.776  CFY <basic> Subgraph started 'install_my_application_3cddc2'
2022-04-05 02:42:55.839  CFY <basic> [my_application_3cddc2] Validating node instance before creation: nothing to do
2022-04-05 02:42:55.864  CFY <basic> [my_application_3cddc2] Precreating node instance: nothing to do
2022-04-05 02:42:55.898  CFY <basic> [my_application_3cddc2] Creating node instance
2022-04-05 02:42:55.934  CFY <basic> [my_application_3cddc2.create] Sending task 'script_runner.tasks.run'
2022-04-05 02:42:57.104  LOG <basic> [my_application_3cddc2.create] INFO: Downloaded scripts/basic/creating.sh to /tmp/1C0FR/creating.sh
2022-04-05 02:42:57.161  LOG <basic> [my_application_3cddc2.create] INFO: Process created, PID: 20212
2022-04-05 02:42:57.238  LOG <basic> [my_application_3cddc2.create] INFO: Creating!
2022-04-05 02:42:57.338  LOG <basic> [my_application_3cddc2.create] INFO: Execution done (PID=20212, return_code=0): /tmp/1C0FR/creating.sh
2022-04-05 02:42:57.558  CFY <basic> [my_application_3cddc2.create] Task succeeded 'script_runner.tasks.run'
2022-04-05 02:42:57.593  CFY <basic> [my_application_3cddc2] Node instance created
2022-04-05 02:42:57.643  CFY <basic> [my_application_3cddc2] Configuring node instance
2022-04-05 02:42:57.681  CFY <basic> [my_application_3cddc2.configure] Sending task 'script_runner.tasks.run'
2022-04-05 02:42:58.551  LOG <basic> [my_application_3cddc2.configure] INFO: Downloaded scripts/basic/configuring.sh to /tmp/NJUDT/configuring.sh
2022-04-05 02:42:58.608  LOG <basic> [my_application_3cddc2.configure] INFO: Process created, PID: 20226
2022-04-05 02:42:58.690  LOG <basic> [my_application_3cddc2.configure] INFO: Configuring!
2022-04-05 02:42:58.788  LOG <basic> [my_application_3cddc2.configure] INFO: Execution done (PID=20226, return_code=0): /tmp/NJUDT/configuring.sh
2022-04-05 02:42:58.971  CFY <basic> [my_application_3cddc2.configure] Task succeeded 'script_runner.tasks.run'
2022-04-05 02:42:59.007  CFY <basic> [my_application_3cddc2] Node instance configured
2022-04-05 02:42:59.054  CFY <basic> [my_application_3cddc2] Starting node instance
2022-04-05 02:42:59.097  CFY <basic> [my_application_3cddc2.start] Sending task 'script_runner.tasks.run'
2022-04-05 02:42:59.978  LOG <basic> [my_application_3cddc2.start] INFO: Downloaded scripts/basic/starting.sh to /tmp/5BI75/starting.sh
2022-04-05 02:43:00.034  LOG <basic> [my_application_3cddc2.start] INFO: Process created, PID: 20240
2022-04-05 02:43:00.086  LOG <basic> [my_application_3cddc2.start] INFO: Starting!
2022-04-05 02:43:00.138  LOG <basic> [my_application_3cddc2.start] INFO: Execution done (PID=20240, return_code=0): /tmp/5BI75/starting.sh
2022-04-05 02:43:00.389  CFY <basic> [my_application_3cddc2.start] Task succeeded 'script_runner.tasks.run'
2022-04-05 02:43:00.417  CFY <basic> [my_application_3cddc2] Poststarting node instance: nothing to do
2022-04-05 02:43:00.453  CFY <basic> [my_application_3cddc2] Node instance started
2022-04-05 02:43:00.491  CFY <basic> Subgraph succeeded 'install_my_application_3cddc2'
2022-04-05 02:43:00.704  CFY <basic> 'install' workflow execution succeeded
Finished executing workflow install on deployment basic
* Run 'cfy events list 843eb2bb-991d-4899-bf1c-dc596b609b5c' to retrieve the execution's events/logs
```

Examine the logs and make sure that all interfaces have been executed
Clean the environment (uninstall, delete deployment and blueprint) using `cfy uninstall`

## Part 3 - Simple OpenStack Blueprint
1. Upload the [openstack V3 plugin](https://github.com/cloudify-cosmo/cloudify-openstack-plugin/releases/tag/3.3.2) to your manager 
2. Upload the `blueprint-osp-vm.yaml`  as blueprint-osp-vm
3. Create a deployment blueprint-osp-vm
4. Run the install workflow
5. Check the IaaS for the new VM

### Part 4 - Simple OpenStack Blueprint - One Blueprint, Two Deployments
6. Create a new deployment using the blueprint-osp-vm (remember the new deployment will need a unique name, also change the inputs to give your server a different name)
7. Inspect the server node and node-instances
8. Uninstall and delete your two deployments

### Part 5 - Simple OpenStack Blueprint - Modify inputs
9. Create a copy of the `blueprint-osp-vm.yaml` file and open it in an editor
10. Eliminate the inputs section by hard coding the inputs values into  the the nodes
11. Upload and test the blueprint

### Part 6 Simple OpenStack Blueprint - Extending the blueprint
12. Extend the blueprint to provision 2 servers
13. Upload and test the extended blueprint

### Part 7 - Introduction to relationships
Based on your updated blueprint-osp-vm (two servers) from previous section:
1. Update the blueprint so one of the servers has a `depends_on` relationship to the other
2. Inspect the installation process
## Additional Optional Exercises 
### Part 8 - Update basic blueprint
Use the basic.yaml blueprint from earlier. 
1. Update the blueprint to have `2 applications in the same host` 
2. Deploy the blueprint and test
3. Clean the environmnet
### Part 9 - Relationships Introduction
Based on previous exercise, modify the bluerpint: 
1. Add a `connected_to` relationship between the 2 applications
2. Deploy the blueprint and test
3. Clean the environment

### Reference: Application node example

```
application_one:
      type: cloudify.nodes.ApplicationModule
      relationships:
        - target: server1
          type: cloudify.relationships.contained_in
```
