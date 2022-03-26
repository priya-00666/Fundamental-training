## Lab 1 Objectives
In this lab you will learn how to:
* upload a blueprint
* explore the CLI help
* add a label to an uploaded blueprint
* create a deployment environment
* install a deployment
* update a deployment
* delete a deployment


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