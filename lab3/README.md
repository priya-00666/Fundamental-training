## Lab 3 Objectives
In this lab you will learn the basics of Service Composition.
## Part 1
A ServiceComponent is a basic type that can be embedded in a blueprint as a component of another blueprint, allowing re-use of micro-services and simplify the creation and readability of blueprints.

The ServiceComponents included in a blueprint will be deployed as part of the blueprint install workflow as a separate deployment linked to the main blueprint in which they were mentioned. Relationships can be defined for ServiceComponents.

One use case for service composition is installing the required infrastructure for an application at the time of application installation. In our case basic_node2 (in basic2.yaml) is our infrastructure that is required for basic_node "application."

1. Modify basic2.yaml (from Lab2) so that `basic_node2` is a ServiceComponent. Save as basic-app.yaml
```
basic_node2:
  type: cloudify.nodes.ServiceComponent
  properties:
    resource_config:
      blueprint:
        external_resource: true
        id: basic-infra
      deployment:
        id: basic-infra
```
2. Modify basic.yaml and save as basic-infra.yaml. It should have a single node `basic_node2`.
```
tosca_definitions_version: cloudify_dsl_1_4

imports:

  - http://www.getcloudify.org/spec/cloudify/6.4.0/types.yaml

node_templates:


  basic_node2:
   type: cloudify.nodes.Root
   properties:
   interfaces:
     cloudify.interfaces.lifecycle:
       create:
         implementation: scripts/basic/creating.sh
         executor: central_deployment_agent
       configure:
         implementation: scripts/basic/configuring.sh
         executor: central_deployment_agent
       start:
         implementation: scripts/basic/starting.sh
         executor: central_deployment_agent
       stop:
         implementation: scripts/basic/stopping.sh
         executor: central_deployment_agent
       delete:
         implementation: scripts/basic/deleting.sh
         executor: central_deployment_agent

```
First we need to upload basic-infra.yaml.
1. `cfy blueprint upload -b basic-infra basic-infra.yaml`

2. Now we can reference that blueprint in our basic-app.yaml. Here's the entire basic-app.yaml blueprint:
```
tosca_definitions_version: cloudify_dsl_1_4

imports:

  - http://www.getcloudify.org/spec/cloudify/6.4.0/types.yaml

node_templates:

  basic_node:
    type: cloudify.nodes.Root
    properties:
    interfaces:
      cloudify.interfaces.lifecycle:
        create:
          implementation: scripts/basic/creating.sh
          executor: central_deployment_agent
        configure:
          implementation: scripts/basic/configuring.sh
          executor: central_deployment_agent
        start:
          implementation: scripts/basic/starting.sh
          executor: central_deployment_agent
        stop:
          implementation: scripts/basic/stopping.sh
          executor: central_deployment_agent
        delete:
          implementation: scripts/basic/deleting.sh
          executor: central_deployment_agent
    relationships:
      - type: cloudify.relationships.connected_to
        target: basic_node2

  basic_node2:
    type: cloudify.nodes.ServiceComponent
    properties:
      resource_config:
        blueprint:
          external_resource: true
          id: basic-infra
        deployment:
          id: basic-infra
```
3. Let's make the basic-app.yaml more flexible by adding inputs for the infra blueprint and deployment ids.

```
tosca_definitions_version: cloudify_dsl_1_4

imports:

  - http://www.getcloudify.org/spec/cloudify/6.4.0/types.yaml
inputs:
  blueprint_id:
    default: basic2
  deployment_id:
    default: basic2

node_templates:

  basic_node:
    type: cloudify.nodes.Root
    properties:
    interfaces:
      cloudify.interfaces.lifecycle:
        create:
          implementation: scripts/basic/creating.sh
          executor: central_deployment_agent
        configure:
          implementation: scripts/basic/configuring.sh
          executor: central_deployment_agent
        start:
          implementation: scripts/basic/starting.sh
          executor: central_deployment_agent
        stop:
          implementation: scripts/basic/stopping.sh
          executor: central_deployment_agent
        delete:
          implementation: scripts/basic/deleting.sh
          executor: central_deployment_agent
    relationships:
      - type: cloudify.relationships.connected_to
        target: basic_node2

  basic_node2:
    type: cloudify.nodes.ServiceComponent
    properties:
      resource_config:
        blueprint:
          external_resource: true
          id: { get_input: blueprint_id }
        deployment:
          id: { get_input: deployment_id }
```
4. Install basic-app.yaml. Don't forget to specify the inputs.
```
cfy install -b basic-app -d basic-app basic-app.yaml -i 'blueprint_id=basic-infra;deployment_id=basic-infra'
Uploading blueprint basic-app.yaml...
 basic-app.yaml |######################################################| 100.0%
Blueprint `basic-app` upload started.
2022-12-18 04:33:50.552  CFY <None> Starting 'upload_blueprint' workflow execution
2022-12-18 04:33:50.598  LOG <None> INFO: Blueprint archive uploaded. Extracting...
2022-12-18 04:33:50.658  LOG <None> INFO: Blueprint archive extracted. Parsing...
2022-12-18 04:33:51.916  LOG <None> INFO: Blueprint parsed. Updating DB with blueprint plan.
2022-12-18 04:33:52.015  CFY <None> 'upload_blueprint' workflow execution succeeded
Blueprint uploaded. The blueprint's id is basic-app
Creating new deployment from blueprint basic-app...
Deployment `basic-app` created. The deployment's id is basic-app
Executing workflow `install` on deployment `basic-app` [timeout=900 seconds]
2022-12-18 04:33:54.065  CFY <basic-app> Starting 'install' workflow execution
2022-12-18 04:33:54.247  CFY <basic-app> Subgraph started 'install_basic_node2_xze2sf'
2022-12-18 04:33:54.286  CFY <basic-app> [basic_node2_xze2sf] Validating node instance before creation: nothing to do
2022-12-18 04:33:54.302  CFY <basic-app> [basic_node2_xze2sf] Precreating node instance: nothing to do
2022-12-18 04:33:54.322  CFY <basic-app> [basic_node2_xze2sf] Creating node instance
2022-12-18 04:33:54.341  CFY <basic-app> [basic_node2_xze2sf.create] Sending task 'cloudify_types.component.upload_blueprint'
2022-12-18 04:33:54.559  CFY <basic-app> [basic_node2_xze2sf.create] Task started 'cloudify_types.component.upload_blueprint'
2022-12-18 04:33:54.777  LOG <basic-app> [basic_node2_xze2sf.create] INFO: Using external blueprint.
2022-12-18 04:33:54.933  CFY <basic-app> [basic_node2_xze2sf.create] Task succeeded 'cloudify_types.component.upload_blueprint' - True
2022-12-18 04:33:54.952  CFY <basic-app> [basic_node2_xze2sf] Node instance created
2022-12-18 04:33:54.975  CFY <basic-app> [basic_node2_xze2sf] Configuring node instance
2022-12-18 04:33:54.998  CFY <basic-app> [basic_node2_xze2sf.configure] Sending task 'cloudify_types.component.create'
2022-12-18 04:33:55.091  CFY <basic-app> [basic_node2_xze2sf.configure] Task started 'cloudify_types.component.create'
2022-12-18 04:33:55.532  LOG <basic-app> [basic_node2_xze2sf.configure] INFO: Creating "basic-infra" component deployment
2022-12-18 04:33:55.850  LOG <basic-app> [basic_node2_xze2sf.configure] INFO: Waiting for log messages (execution: 0eacf53b-853a-4552-9e86-16b2fc6228d4)...
2022-12-18 04:33:56.963  LOG <basic-app> [basic_node2_xze2sf.configure] INFO: 2022-12-18T04:33:55.918Z Starting 'create_deployment_environment' workflow execution
2022-12-18 04:33:56.979  LOG <basic-app> [basic_node2_xze2sf.configure] INFO: 2022-12-18T04:33:55.998Z Setting deployment attributes
2022-12-18 04:33:56.996  LOG <basic-app> [basic_node2_xze2sf.configure] INFO: 2022-12-18T04:33:56.088Z Creating 1 nodes
2022-12-18 04:33:57.012  LOG <basic-app> [basic_node2_xze2sf.configure] INFO: 2022-12-18T04:33:56.126Z Creating 1 node-instances
2022-12-18 04:33:57.027  LOG <basic-app> [basic_node2_xze2sf.configure] INFO: 2022-12-18T04:33:56.182Z Creating deployment work directory
2022-12-18 04:33:57.043  LOG <basic-app> [basic_node2_xze2sf.configure] INFO: 2022-12-18T04:33:56.246Z 'create_deployment_environment' workflow execution succeeded
2022-12-18 04:33:57.241  CFY <basic-app> [basic_node2_xze2sf.configure] Task succeeded 'cloudify_types.component.create' - True
2022-12-18 04:33:57.260  CFY <basic-app> [basic_node2_xze2sf] Node instance configured
2022-12-18 04:33:57.282  CFY <basic-app> [basic_node2_xze2sf] Starting node instance
2022-12-18 04:33:57.303  CFY <basic-app> [basic_node2_xze2sf.start] Sending task 'cloudify_types.component.execute_start'
2022-12-18 04:33:57.396  CFY <basic-app> [basic_node2_xze2sf.start] Task started 'cloudify_types.component.execute_start'
2022-12-18 04:33:57.677  LOG <basic-app> [basic_node2_xze2sf.start] INFO: Starting execution for "basic-infra" deployment
2022-12-18 04:33:57.919  LOG <basic-app> [basic_node2_xze2sf.start] INFO: Waiting for log messages (execution: 74911879-e7f7-4e01-9497-1e0cf6da554e)...
2022-12-18 04:33:59.010  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:58.193Z Starting 'install' workflow execution
2022-12-18 04:33:59.026  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:58.301Z Subgraph started 'install_basic_node2_t3ht7q'
2022-12-18 04:33:59.041  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:58.337Z [basic_node2_t3ht7q] Validating node instance before creation: nothing to do
2022-12-18 04:33:59.058  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:58.352Z [basic_node2_t3ht7q] Precreating node instance: nothing to do
2022-12-18 04:33:59.077  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:58.372Z [basic_node2_t3ht7q] Creating node instance
2022-12-18 04:33:59.097  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:58.393Z [basic_node2_t3ht7q.create] Sending task 'script_runner.tasks.run'
2022-12-18 04:33:59.118  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:58.611Z [basic_node2_t3ht7q.create] Task started 'script_runner.tasks.run'
2022-12-18 04:33:59.137  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:58.835Z [basic_node2_t3ht7q.create] Downloaded scripts/basic/creating.sh to /tmp/HKP5X/creating.sh
2022-12-18 04:33:59.175  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:58.872Z [basic_node2_t3ht7q.create] Process created, PID: 53181
2022-12-18 04:33:59.227  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:58.953Z [basic_node2_t3ht7q.create] Creating!
2022-12-18 04:34:00.329  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:59.021Z [basic_node2_t3ht7q.create] Execution done (PID=53181, return_code=0): /tmp/HKP5X/creating.sh
2022-12-18 04:34:00.448  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:59.289Z [basic_node2_t3ht7q.create] Task succeeded 'script_runner.tasks.run'
2022-12-18 04:34:00.465  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:59.310Z [basic_node2_t3ht7q] Node instance created
2022-12-18 04:34:00.481  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:59.334Z [basic_node2_t3ht7q] Configuring node instance
2022-12-18 04:34:00.500  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:59.356Z [basic_node2_t3ht7q.configure] Sending task 'script_runner.tasks.run'
2022-12-18 04:34:00.518  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:59.448Z [basic_node2_t3ht7q.configure] Task started 'script_runner.tasks.run'
2022-12-18 04:34:00.537  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:59.661Z [basic_node2_t3ht7q.configure] Downloaded scripts/basic/configuring.sh to /tmp/CK135/configuring.sh
2022-12-18 04:34:00.573  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:59.696Z [basic_node2_t3ht7q.configure] Process created, PID: 53188
2022-12-18 04:34:00.624  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:59.779Z [basic_node2_t3ht7q.configure] Configuring!
2022-12-18 04:34:00.639  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:33:59.848Z [basic_node2_t3ht7q.configure] Execution done (PID=53188, return_code=0): /tmp/CK135/configuring.sh
2022-12-18 04:34:00.739  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.075Z [basic_node2_t3ht7q.configure] Task succeeded 'script_runner.tasks.run'
2022-12-18 04:34:00.757  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.096Z [basic_node2_t3ht7q] Node instance configured
2022-12-18 04:34:00.776  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.122Z [basic_node2_t3ht7q] Starting node instance
2022-12-18 04:34:00.793  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.146Z [basic_node2_t3ht7q.start] Sending task 'script_runner.tasks.run'
2022-12-18 04:34:00.813  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.232Z [basic_node2_t3ht7q.start] Task started 'script_runner.tasks.run'
2022-12-18 04:34:01.908  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.474Z [basic_node2_t3ht7q.start] Downloaded scripts/basic/starting.sh to /tmp/18ZTG/starting.sh
2022-12-18 04:34:01.939  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.515Z [basic_node2_t3ht7q.start] Process created, PID: 53197
2022-12-18 04:34:01.986  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.600Z [basic_node2_t3ht7q.start] Starting!
2022-12-18 04:34:02.001  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.670Z [basic_node2_t3ht7q.start] Execution done (PID=53197, return_code=0): /tmp/18ZTG/starting.sh
2022-12-18 04:34:02.095  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.955Z [basic_node2_t3ht7q.start] Task succeeded 'script_runner.tasks.run'
2022-12-18 04:34:02.111  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.973Z [basic_node2_t3ht7q] Poststarting node instance: nothing to do
2022-12-18 04:34:02.128  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:00.990Z [basic_node2_t3ht7q] Node instance started
2022-12-18 04:34:02.147  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:01.012Z Subgraph succeeded 'install_basic_node2_t3ht7q'
2022-12-18 04:34:02.165  LOG <basic-app> [basic_node2_xze2sf.start] INFO: 2022-12-18T04:34:01.135Z 'install' workflow execution succeeded
2022-12-18 04:34:02.215  LOG <basic-app> [basic_node2_xze2sf.start] INFO: Execution succeeded for "basic-infra" deployment
2022-12-18 04:34:02.232  LOG <basic-app> [basic_node2_xze2sf.start] INFO: Fetching "basic-infra" deployment capabilities..
2022-12-18 04:34:02.283  LOG <basic-app> [basic_node2_xze2sf.start] INFO: Fetched capabilities:
{}
2022-12-18 04:34:02.437  CFY <basic-app> [basic_node2_xze2sf.start] Task succeeded 'cloudify_types.component.execute_start' - True
2022-12-18 04:34:02.456  CFY <basic-app> [basic_node2_xze2sf] Poststarting node instance: nothing to do
2022-12-18 04:34:02.477  CFY <basic-app> [basic_node2_xze2sf] Node instance started
2022-12-18 04:34:02.505  CFY <basic-app> Subgraph succeeded 'install_basic_node2_xze2sf'
2022-12-18 04:34:02.527  CFY <basic-app> Subgraph started 'install_basic_node_tkyaj7'
2022-12-18 04:34:02.565  CFY <basic-app> [basic_node_tkyaj7] Validating node instance before creation: nothing to do
2022-12-18 04:34:02.582  CFY <basic-app> [basic_node_tkyaj7] Precreating node instance: nothing to do
2022-12-18 04:34:02.603  CFY <basic-app> [basic_node_tkyaj7] Creating node instance
2022-12-18 04:34:02.625  CFY <basic-app> [basic_node_tkyaj7.create] Sending task 'script_runner.tasks.run'
2022-12-18 04:34:02.742  CFY <basic-app> [basic_node_tkyaj7.create] Task started 'script_runner.tasks.run'
2022-12-18 04:34:02.963  LOG <basic-app> [basic_node_tkyaj7.create] INFO: Downloaded scripts/basic/creating.sh to /tmp/VXQW1/creating.sh
2022-12-18 04:34:02.999  LOG <basic-app> [basic_node_tkyaj7.create] INFO: Process created, PID: 53214
2022-12-18 04:34:03.083  LOG <basic-app> [basic_node_tkyaj7.create] INFO: Creating!
2022-12-18 04:34:03.152  LOG <basic-app> [basic_node_tkyaj7.create] INFO: Execution done (PID=53214, return_code=0): /tmp/VXQW1/creating.sh
2022-12-18 04:34:03.417  CFY <basic-app> [basic_node_tkyaj7.create] Task succeeded 'script_runner.tasks.run'
2022-12-18 04:34:03.438  CFY <basic-app> [basic_node_tkyaj7] Node instance created
2022-12-18 04:34:03.460  CFY <basic-app> [basic_node_tkyaj7] Configuring node instance
2022-12-18 04:34:03.482  CFY <basic-app> [basic_node_tkyaj7.configure] Sending task 'script_runner.tasks.run'
2022-12-18 04:34:03.588  CFY <basic-app> [basic_node_tkyaj7.configure] Task started 'script_runner.tasks.run'
2022-12-18 04:34:03.822  LOG <basic-app> [basic_node_tkyaj7.configure] INFO: Downloaded scripts/basic/configuring.sh to /tmp/4R75R/configuring.sh
2022-12-18 04:34:03.859  LOG <basic-app> [basic_node_tkyaj7.configure] INFO: Process created, PID: 53223
2022-12-18 04:34:03.944  LOG <basic-app> [basic_node_tkyaj7.configure] INFO: Configuring!
2022-12-18 04:34:04.009  LOG <basic-app> [basic_node_tkyaj7.configure] INFO: Execution done (PID=53223, return_code=0): /tmp/4R75R/configuring.sh
2022-12-18 04:34:04.245  CFY <basic-app> [basic_node_tkyaj7.configure] Task succeeded 'script_runner.tasks.run'
2022-12-18 04:34:04.264  CFY <basic-app> [basic_node_tkyaj7] Node instance configured
2022-12-18 04:34:04.287  CFY <basic-app> [basic_node_tkyaj7] Starting node instance
2022-12-18 04:34:04.309  CFY <basic-app> [basic_node_tkyaj7.start] Sending task 'script_runner.tasks.run'
2022-12-18 04:34:04.400  CFY <basic-app> [basic_node_tkyaj7.start] Task started 'script_runner.tasks.run'
2022-12-18 04:34:04.621  LOG <basic-app> [basic_node_tkyaj7.start] INFO: Downloaded scripts/basic/starting.sh to /tmp/6Z09S/starting.sh
2022-12-18 04:34:04.657  LOG <basic-app> [basic_node_tkyaj7.start] INFO: Process created, PID: 53230
2022-12-18 04:34:04.741  LOG <basic-app> [basic_node_tkyaj7.start] INFO: Starting!
2022-12-18 04:34:04.806  LOG <basic-app> [basic_node_tkyaj7.start] INFO: Execution done (PID=53230, return_code=0): /tmp/6Z09S/starting.sh
2022-12-18 04:34:05.025  CFY <basic-app> [basic_node_tkyaj7.start] Task succeeded 'script_runner.tasks.run'
2022-12-18 04:34:05.042  CFY <basic-app> [basic_node_tkyaj7] Poststarting node instance: nothing to do
2022-12-18 04:34:05.059  CFY <basic-app> [basic_node_tkyaj7] Node instance started
2022-12-18 04:34:05.082  CFY <basic-app> Subgraph succeeded 'install_basic_node_tkyaj7'
2022-12-18 04:34:05.203  CFY <basic-app> 'install' workflow execution succeeded
Finished executing workflow install on deployment basic-app
* Run 'cfy events list ea3775cf-e83e-420e-96d8-af3f5df569b7' to retrieve the execution's events/logs        
```
Using ServiceComponents allows chaining of applications and services. For further details please see the [documentation](https://docs.cloudify.co/latest/working_with/service_composition/).

5. (optional) Try out [Environment as a Service demo](https://docs.cloudify.co/latest/trial_getting_started/examples/eaas/). 
