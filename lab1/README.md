## Lab 1 Objectives
In this lab you will learn how use the Cloudify CLI to:
* Upload a blueprint
* Explore the CLI help
* Add a label to an uploaded blueprint
* Create a deployment environment
* Install a deployment
* Update a deployment
* Delete a deployment


References for this lab: [CLI Blueprints documenation](https://docs.cloudify.co/latest/cli/orch_cli/blueprints/), [CLI Deployments documentation](https://docs.cloudify.co/latest/cli/orch_cli/deployments/)

## Uploading Blueprints

The quickest way to upload blueprints to a Cloudify manager is with the command line via the `cfy blueprint upload` command. This should be executed from within the directory containing the blueprint.

Note, you can upload multiple copies of a blueprint file, but each copy will need to have a unique blueprint id.

For example, the following command uploads the hello.yaml blueprint to the Cloudify manager, and gives it a blueprint id of `hello`:

```
>$ pwd
/home/centos/fundamentals-training
[>$ cfy blueprints upload -b hello hello.yaml
Uploading blueprint hello.yaml...
 hello.yaml |##########################################################| 100.0%
Blueprint `hello` upload started.
2022-03-26 11:58:41.589  CFY <None> Starting 'upload_blueprint' workflow execution
2022-03-26 11:58:41.676  LOG <None> INFO: Blueprint archive uploaded. Extracting...
2022-03-26 11:58:41.847  LOG <None> INFO: Blueprint archive extracted. Parsing...
2022-03-26 11:58:44.445  LOG <None> INFO: Blueprint parsed. Updating DB with blueprint plan.
2022-03-26 11:58:44.707  CFY <None> 'upload_blueprint' workflow execution succeeded
Blueprint uploaded. The blueprint's id is hello
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
## Listing Uploaded Blueprints
```
cfy blueprints list
Listing all blueprints...

Blueprints:
+-------+-------------+----------------+--------------------------+--------------------------+------------+----------------+------------+----------+-------+--------+
|   id  | description | main_file_name |        created_at        |        updated_at        | visibility |  tenant_name   | created_by |  state   | error | labels |
+-------+-------------+----------------+--------------------------+--------------------------+------------+----------------+------------+----------+-------+--------+
| hello |             |   hello.yaml   | 2022-03-26 12:07:07.224  | 2022-03-26 12:07:22.416  |   tenant   | default_tenant |   admin    | uploaded |       |        |
+-------+-------------+----------------+--------------------------+--------------------------+------------+----------------+------------+----------+-------+--------+

Showing 1 of 1 blueprints
```
## Other Blueprints Commands

You can use the CLI help to explore commands/subcommands.
```
>$cfy blueprints -h
Usage: cfy blueprints [OPTIONS] COMMAND [ARGS]...

  Handle blueprints on the manager

Options:
  --manager TEXT         Connect to a specific manager by IP or host
  -q, --quiet            Show only critical logs
  --format [plain|json]
  -v, --verbose          Show verbose output. You can supply this up to three
                         times (i.e. -vvv)

  --json
  -h, --help             Show this message and exit.

Commands:
  create-requirements  Create pip-requirements
  delete               Delete a blueprint [manager only]
  download             Download a blueprint [manager only]
  filters              Handle the blueprints' filters
  get                  Retrieve blueprint information [manager only]
  inputs               Retrieve blueprint inputs [manager only]
  labels               Handle a blueprint's labels
  list                 List blueprints
  package              Create a blueprint archive
  set-global           Set the blueprint's visibility to global
  set-icon             Set or remove blueprint's icon
  set-owner            Change blueprint's ownership
  set-visibility       Set the blueprint's visibility
  summary              Retrieve summary of blueprint details [manager only]
  upload               Upload a blueprint [manager only]
  validate             Validate a blueprint
```
## Adding a Blueprint Label

Let's add a label to our `hello` blueprint. First, let's check the CLI help to see how to do that.

```
>$cfy blueprints labels -h
Usage: cfy blueprints labels [OPTIONS] COMMAND [ARGS]...

Options:
  --manager TEXT         Connect to a specific manager by IP or host
  -q, --quiet            Show only critical logs
  --format [plain|json]
  -v, --verbose          Show verbose output. You can supply this up to three
                         times (i.e. -vvv)

  --json
  -h, --help             Show this message and exit.

Commands:
  add     Add labels to a specific blueprint
  delete  Delete labels from a specific blueprint
  list    List the labels of a specific blueprint
```
Now, you can add a label:
```
>$cfy blueprints labels add training:lab1 hello
Adding labels to blueprint hello...
The following label(s) were added successfully to blueprint hello: [{'training': 'lab1'}]
```
## Creating a deployment
Use the CLI help to explore the `deployments` command on your own. And then create a deployment environment.
```
>$cfy deployments create hello -b hello
Creating new deployment from blueprint hello...
Deployment `hello` created. The deployment's id is hello
```

## Installing a Deployment

Now, you can run the install workflow.
```
>cfy exec start install -d hello
Executing workflow `install` on deployment `hello` [timeout=900 seconds]
2022-04-05 01:53:43.040  CFY <hello> Starting 'install' workflow execution
2022-04-05 01:53:43.246  CFY <hello> Subgraph started 'install_http_web_server_ohew49'
2022-04-05 01:53:43.325  CFY <hello> [http_web_server_ohew49] Validating node instance before creation: nothing to do
2022-04-05 01:53:43.355  CFY <hello> [http_web_server_ohew49] Precreating node instance: nothing to do
2022-04-05 01:53:43.400  CFY <hello> [http_web_server_ohew49] Creating node instance
2022-04-05 01:53:43.446  CFY <hello> [http_web_server_ohew49.create] Sending task 'script_runner.tasks.run'
2022-04-05 01:53:44.156  CFY <hello> [http_web_server_ohew49.create] Task started 'script_runner.tasks.run'
2022-04-05 01:53:44.996  LOG <hello> [http_web_server_ohew49.create] INFO: Downloaded hello-resources/install.py to /tmp/SYT3I/install.py
2022-04-05 01:53:45.088  LOG <hello> [http_web_server_ohew49.create] INFO: Running WebServer locally on port: 8000
2022-04-05 01:53:45.161  LOG <hello> [http_web_server_ohew49.create] INFO: Setting `pid` runtime property: 10551
2022-04-05 01:53:45.251  LOG <hello> [http_web_server_ohew49.create] INFO: Trying to find the host IP
2022-04-05 01:53:45.636  LOG <hello> [http_web_server_ohew49.create] INFO: The application endpoint is http://35.242.175.59:8000
2022-04-05 01:53:45.885  CFY <hello> [http_web_server_ohew49.create] Task succeeded 'script_runner.tasks.run'
2022-04-05 01:53:45.926  CFY <hello> [http_web_server_ohew49] Node instance created
2022-04-05 01:53:45.972  CFY <hello> [http_web_server_ohew49] Configuring node instance: nothing to do
2022-04-05 01:53:46.004  CFY <hello> [http_web_server_ohew49] Starting node instance: nothing to do
2022-04-05 01:53:46.032  CFY <hello> [http_web_server_ohew49] Poststarting node instance: nothing to do
2022-04-05 01:53:46.069  CFY <hello> [http_web_server_ohew49] Node instance started
2022-04-05 01:53:46.113  CFY <hello> Subgraph succeeded 'install_http_web_server_ohew49'
2022-04-05 01:53:46.231  CFY <hello> 'install' workflow execution succeeded
Finished executing workflow install on deployment hello
* Run 'cfy events list f08398f6-7e7e-4d0e-8226-7ec35830eb62' to retrieve the execution's events/logs
```
You can check the deployments output to find the endpoint of the web application.
```
>cfy deployments output hello
Retrieving outputs for deployment hello...
 - "application_endpoint":
     Description: The external endpoint of the application.
     Value: http://<MANAGER_IP>:8000

```
Open the link in your browser. Congrats! You've deployed your first application.

## Updating a Deployment
First, let's check the deployment inputs by looking at hello.yaml or with the CLI.
```
>cfy deployments inputs hello
Retrieving inputs for deployment hello...
 - "webserver_port":
     Value: 8000
```
And now we'll update the deployment to use a different port.

```
 cfy dep update -i 'webserver_port=8800' hello
Updating deployment hello with new inputs
2022-04-05 02:08:01.701  CFY <hello> Starting 'update' workflow execution
2022-04-05 02:08:01.819  CFY <hello> Task started 'prepare_plan'
2022-04-05 02:08:01.962  CFY <hello> Task succeeded 'prepare_plan'
2022-04-05 02:08:01.987  CFY <hello> Task started 'create_steps'
2022-04-05 02:08:02.161  CFY <hello> Task succeeded 'create_steps'
2022-04-05 02:08:02.185  CFY <hello> Task started 'prepare_update_nodes'
2022-04-05 02:08:02.424  CFY <hello> Task succeeded 'prepare_update_nodes'
2022-04-05 02:08:02.457  CFY <hello> Task started 'prepare_plugin_changes'
2022-04-05 02:08:02.637  CFY <hello> Task succeeded 'prepare_plugin_changes'
2022-04-05 02:08:02.668  CFY <hello> Task started 'set_deployment_attributes'
2022-04-05 02:08:02.814  CFY <hello> Task succeeded 'set_deployment_attributes'
2022-04-05 02:08:02.836  CFY <hello> Task started 'update_inter_deployment_dependencies'
2022-04-05 02:08:02.974  CFY <hello> Task succeeded 'update_inter_deployment_dependencies'
2022-04-05 02:08:03.000  CFY <hello> Task started 'update_deployment_nodes'
2022-04-05 02:08:03.168  CFY <hello> Task succeeded 'update_deployment_nodes'
2022-04-05 02:08:03.192  CFY <hello> Task started 'update_deployment_node_instances'
2022-04-05 02:08:03.250  CFY <hello> Task succeeded 'update_deployment_node_instances'
2022-04-05 02:08:03.479  CFY <hello> Subgraph started 'http_web_server_ew7uzp'
2022-04-05 02:08:03.512  CFY <hello> [http_web_server_ew7uzp] Stopping node instance
2022-04-05 02:08:03.558  CFY <hello> [http_web_server_ew7uzp] Validating node instance after deletion: nothing to do
2022-04-05 02:08:03.584  CFY <hello> [http_web_server_ew7uzp] Stopped node instance: nothing to do
2022-04-05 02:08:03.651  CFY <hello> [http_web_server_ew7uzp] Deleting node instance
2022-04-05 02:08:03.689  CFY <hello> [http_web_server_ew7uzp.delete] Sending task 'script_runner.tasks.run'
2022-04-05 02:08:03.937  CFY <hello> [http_web_server_ew7uzp.delete] Task started 'script_runner.tasks.run'
2022-04-05 02:08:04.747  LOG <hello> [http_web_server_ew7uzp.delete] INFO: Downloaded hello-resources/uninstall.py to /tmp/KMD9O/uninstall.py
2022-04-05 02:08:04.804  LOG <hello> [http_web_server_ew7uzp.delete] INFO: Running process PID: 11451
2022-04-05 02:08:04.828  LOG <hello> [http_web_server_ew7uzp.delete] INFO: Python Webserver Terminated!
2022-04-05 02:08:05.065  CFY <hello> [http_web_server_ew7uzp.delete] Task succeeded 'script_runner.tasks.run'
2022-04-05 02:08:05.098  CFY <hello> [http_web_server_ew7uzp] Deleted node instance
2022-04-05 02:08:05.137  CFY <hello> Subgraph succeeded 'http_web_server_ew7uzp'
2022-04-05 02:08:05.306  CFY <hello> Subgraph started 'install_http_web_server_ew7uzp'
2022-04-05 02:08:05.367  CFY <hello> [http_web_server_ew7uzp] Validating node instance before creation: nothing to do
2022-04-05 02:08:05.397  CFY <hello> [http_web_server_ew7uzp] Precreating node instance: nothing to do
2022-04-05 02:08:05.436  CFY <hello> [http_web_server_ew7uzp] Creating node instance
2022-04-05 02:08:05.489  CFY <hello> [http_web_server_ew7uzp.create] Sending task 'script_runner.tasks.run'
2022-04-05 02:08:05.627  CFY <hello> [http_web_server_ew7uzp.create] Task started 'script_runner.tasks.run'
2022-04-05 02:08:06.349  LOG <hello> [http_web_server_ew7uzp.create] INFO: Downloaded hello-resources/install.py to /tmp/DYBPH/install.py
2022-04-05 02:08:06.420  LOG <hello> [http_web_server_ew7uzp.create] INFO: Running WebServer locally on port: 8800
2022-04-05 02:08:06.458  LOG <hello> [http_web_server_ew7uzp.create] INFO: Setting `pid` runtime property: 11600
2022-04-05 02:08:06.533  LOG <hello> [http_web_server_ew7uzp.create] INFO: Trying to find the host IP
2022-04-05 02:08:06.924  LOG <hello> [http_web_server_ew7uzp.create] INFO: The application endpoint is http://35.242.175.59:8800
2022-04-05 02:08:07.188  CFY <hello> [http_web_server_ew7uzp.create] Task succeeded 'script_runner.tasks.run'
2022-04-05 02:08:07.245  CFY <hello> [http_web_server_ew7uzp] Node instance created
2022-04-05 02:08:07.284  CFY <hello> [http_web_server_ew7uzp] Configuring node instance: nothing to do
2022-04-05 02:08:07.310  CFY <hello> [http_web_server_ew7uzp] Starting node instance: nothing to do
2022-04-05 02:08:07.334  CFY <hello> [http_web_server_ew7uzp] Poststarting node instance: nothing to do
2022-04-05 02:08:07.371  CFY <hello> [http_web_server_ew7uzp] Node instance started
2022-04-05 02:08:07.425  CFY <hello> Subgraph succeeded 'install_http_web_server_ew7uzp'
2022-04-05 02:08:07.490  CFY <hello> Task started 'delete_removed_nodes'
2022-04-05 02:08:07.546  CFY <hello> Task succeeded 'delete_removed_nodes'
2022-04-05 02:08:07.576  CFY <hello> Task started 'delete_removed_relationships'
2022-04-05 02:08:07.703  CFY <hello> Task succeeded 'delete_removed_relationships'
2022-04-05 02:08:07.727  CFY <hello> Task started 'update_schedules'
2022-04-05 02:08:07.784  CFY <hello> Task succeeded 'update_schedules'
2022-04-05 02:08:07.808  CFY <hello> Task started 'update_operations'
2022-04-05 02:08:07.887  CFY <hello> Task succeeded 'update_operations'
2022-04-05 02:08:08.039  CFY <hello> 'update' workflow execution succeeded
Finished executing workflow 'update' on deployment 'hello'
Successfully updated deployment hello. Deployment update id: hello-7baa4f08-9cb9-4228-9d2f-662e2d42a7b8. Execution id: eebf789e-3cdb-4c41-a138-cec527a06f73
```
Check the browser for the updated application.
## Uninstall and Delete the Deployment
Before deleting the deployment, it must be uninstalled.
```
>cfy executions start uninstall -d hello
Executing workflow `uninstall` on deployment `hello` [timeout=900 seconds]
2022-04-05 02:13:23.881  CFY <hello> Starting 'uninstall' workflow execution
2022-04-05 02:13:24.043  CFY <hello> Subgraph started 'http_web_server_ew7uzp'
2022-04-05 02:13:24.078  CFY <hello> [http_web_server_ew7uzp] Stopping node instance
2022-04-05 02:13:24.120  CFY <hello> [http_web_server_ew7uzp] Validating node instance after deletion: nothing to do
2022-04-05 02:13:24.146  CFY <hello> [http_web_server_ew7uzp] Stopped node instance: nothing to do
2022-04-05 02:13:24.219  CFY <hello> [http_web_server_ew7uzp] Deleting node instance
2022-04-05 02:13:24.252  CFY <hello> [http_web_server_ew7uzp.delete] Sending task 'script_runner.tasks.run'
2022-04-05 02:13:24.500  CFY <hello> [http_web_server_ew7uzp.delete] Task started 'script_runner.tasks.run'
2022-04-05 02:13:25.274  LOG <hello> [http_web_server_ew7uzp.delete] INFO: Downloaded hello-resources/uninstall.py to /tmp/SWFL8/uninstall.py
2022-04-05 02:13:25.332  LOG <hello> [http_web_server_ew7uzp.delete] INFO: Running process PID: 11600
2022-04-05 02:13:25.357  LOG <hello> [http_web_server_ew7uzp.delete] INFO: Python Webserver Terminated!
2022-04-05 02:13:25.580  CFY <hello> [http_web_server_ew7uzp.delete] Task succeeded 'script_runner.tasks.run'
2022-04-05 02:13:25.612  CFY <hello> [http_web_server_ew7uzp] Deleted node instance
2022-04-05 02:13:25.652  CFY <hello> Subgraph succeeded 'http_web_server_ew7uzp'
2022-04-05 02:13:25.773  CFY <hello> 'uninstall' workflow execution succeeded
Finished executing workflow uninstall on deployment hello
* Run 'cfy events list bb629fe2-9b68-4bde-a640-1ed2e9817a5f' to retrieve the execution's events/logs
```
Finally, let's delete the deployment.
```
>cfy deployments delete hello
Trying to delete deployment hello...
Deployment deleted
```
