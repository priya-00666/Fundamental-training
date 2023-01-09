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

## Part 1 - YAML drill (optional)
1. Create a YAML file that contains the following elements and validate it:
* Dictionary with 2 keys: `hostnames` and `content`
* The key `hostnames` value is a list of: `app, data and proxy`
* The key `content` value is a list of: `node.js, mysql and nginx`
2. Find an online [YAML validator](http://www.yamllint.com/) and validate your file.

##Part 2 - Validate a blueprint
Blueprints (not ordinary YAML files) can be validated with the Cloudify manager.
1. Use `cfy blueprints` to validate basic.yaml from this repo.

```
$ cfy blueprints validate basic.yaml
Validating blueprint: basic.yaml
Blueprint validated successfully
```
When a blueprint fails to validate, guidance will be given to help find the error.
2. Modify basic.yaml, use `#` to comment out `cloudify.nodes.Root`, like this:
```
basic_node:
    type: #cloudify.nodes.Root
```
3. Now, try and validate the blueprint again.

```
$ cfy blueprints validate basic.yaml
Validating blueprint: basic.yaml
Failed to validate blueprint: 'type' key is required but it is currently missing
  in: basic.yaml
  in line: 10, column: 4
  path: node_templates.basic_node.type
  value: None
```
4. After checking the error, remove the comment and revalidate.

## Part 3: Basic Blueprint Overview
Blueprints are YAML documents written in Cloudify’s DSL (Domain Specific Language), based on TOSCA. Blueprints describe the topology infrastructure and applications.

Blueprints are packaged into a blueprint archive, which contains a main blueprint YAML file, and other resources, such as scripts and imports.
Please check the documentation for a complete [blueprint reference](https://docs.cloudify.co/latest/developer/blueprints/).

The blueprint `basic.yaml` represents the most simple blueprint structure.
```
tosca_definitions_version: cloudify_dsl_1_4

imports:

  - http://www.getcloudify.org/spec/cloudify/6.4.0/types.yaml

node_templates:

  basic_node:
    type: cloudify.nodes.Root
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
It has the three required sections:
* TOSCA definition version
* Import of basic Cloudify types.yaml
* Each blueprint must include at least one node template

We'll be covering fundamental blueprint elements including:
* Intrinsic functions: inputs, ouputs, capabilities, secrets  
* Node templates
* Node types
* Relationships
* Plugins
* Interfaces

## Part 4 - Modifying hello.yaml blueprint

1. Modify hello.yaml so that the webserver port is defined by a secret, rather than an input.
2. Reference the port secret with the `get_secret` intrinsic function.
3. Save the blueprint as `hello-secret.yaml`
4. Validate your blueprint.

**Note:**Your blueprint will validate even if you haven't created the secret yet. That's because secrets are evaluated at runtime - at the time of deployment creation.

5. Try to install your blueprint.
```
cfy install -b hello-secret -d hello-secret hello-secret.yaml
Uploading blueprint hello.yaml...
 hello.yaml |##########################################################| 100.0%
Blueprint `hello-secret` upload started.
2022-12-09 01:51:12.705  CFY <None> Starting 'upload_blueprint' workflow execution
2022-12-09 01:51:12.755  LOG <None> INFO: Blueprint archive uploaded. Extracting...
2022-12-09 01:51:12.818  LOG <None> INFO: Blueprint archive extracted. Parsing...
2022-12-09 01:51:13.740  LOG <None> INFO: Blueprint parsed. Updating DB with blueprint plan.
2022-12-09 01:51:13.844  CFY <None> 'upload_blueprint' workflow execution succeeded
Blueprint uploaded. The blueprint's id is hello-secret
Creating new deployment from blueprint hello-secret...
An error occurred on the server: 400: dsl_parser.exceptions.UnknownSecretError: Required secrets: [webserver_port] don't exist in this tenant
[10498] Failed to execute script 'main' due to unhandled exception!
```
6. Create your secret `webserver_port`
```
$ cfy secret create webserver_port -s 8000
Secret `webserver_port` created
```
7. Now, try to install again. **Note**: rerunning the same command will fail if you don't remove `hello-secret` or give it a unique blueprint id. Or, rather than running the `cfy install` command, use `cfy deployment create` and `cfy execution start install` like we did in Lab 1.
```
$ cfy deployment create -b hello-secret hello-secret
Creating new deployment from blueprint hello-secret...
Deployment `hello-secret` created. The deployment's id is hello-secret
$ cfy executions start install -d hello-secret
...
```
8. Remember to cleanup by uninstalling and deleting deployments and deleting blueprints.

## Part 5 - Blueprint input contstraints
Inputs are used to provide parameters used for deployment creation. Inputs can be constrained in a number of ways. Please check the [inputs documentation](https://docs.cloudify.co/latest/developer/blueprints/spec-inputs) for full details.
1. Modify hello.yaml to constrain the `webserver_port` to have a fixed list of available ports to use at the time of deployment.
2. Save your blueprint as `hello-input.yaml`
3. Validate and upload `hello-input.yaml`.
4. Create a deployment and check that you can only specify a specified port.
```
webserver_port:
  description: The HTTP web server port.
  default: 8000
  constraints:
    - valid_values:
        - 8000
        - 7000
        - 6000
```        
5. Cleanup your resources.
6. Modify the blueprint inputs to constrain the `webserver_port` to a valid range.
7. Save your blueprint as `hello-range.yaml`
8. Validate and upload `hello-range.yaml`
9. Create a deployment and check that you can only specify a specified port.           

## Part 6 - Extending basic.yaml blueprint
1. Upload basic.yaml and have a look at the topology in the UI on the Blueprint page. You'll see a single node `basic_node`.
2. Modify basic.yaml so that there are two nodes. You can copy `basic_node` and create `basic_node2`.
3. Save your modified blueprint as `basic2.yaml`.
4. Validate and then upload `basic2.yaml`.
5. Have a look at the new topology in the UI. You can move the nodes to your desired positions and save the layout. Check out the [topology widget documentation](https://docs.cloudify.co/latest/working_with/console/widgets/topology/) for further details.

## Part 7 - Blueprint relationships
Relationships define how nodes relate to other nodes.  We use `source` and `target` to reference the nodes. The `source` node is where the relationship to the target is defined. For example, a web_server node can be contained_in a vm node or an application node can be connected_to a database node.

```
node_templates:

  vm:
    type: cloudify.nodes.Compute


  http_web_server:
    type: cloudify.nodes.WebServer
    properties:
      port: { get_input: webserver_port }
    relationships:
      - type: cloudify.relationships.contained_in
        target: vm
    interfaces:
      cloudify.interfaces.lifecycle:
        configure: scripts/configure.sh
        start:
          implementation: scripts/start.sh
          inputs:
            process:
              env:
                port: { get_input: webserver_port }
        stop: scripts/stop.sh
```        
The basic relationship types are:
* cloudify.relationships.depends_on
* cloudify.relationships.connected_to
* cloudify.relationships.contained_in
1. Modify basic2.yaml by creating a `cloudify.relationships.connected_to` relationship between `basic_node` and `basic_node2`.
2. Validate and upload basic2.yaml.
3. Inspect the blueprint topology in the UI.
4. Modify basic2.yaml by changing the relationship type to `cloudify.relationships.contained_in`.
5. Validate and upload basic2.yaml.
6. Inspect the blueprint topology in the UI.

See the [relationship documentation](https://docs.cloudify.co/latest/developer/blueprints/spec-relationships/) for further details.
## Part 8 - Importing plugins (optional)
Cloudify uses plugins to interact with with external systems like cloud providers and with tools like Terraform and Ansible.
```
imports:
  - https://cloudify.co/spec/cloudify/6.4.0/types.yaml
  - plugin:cloudify-ansible-plugin
  - plugin:cloudify-aws-plugin
```
Official Cloudify plugins are opensource. Each plugin has its own types defined. You should check the type files for usage details like node_types and data_types. For example, you can take a look at the [AWS plugin](https://github.com/cloudify-cosmo/cloudify-aws-plugin/blob/master/plugin_1_4.yaml).

1. Upload Cloudify plugins via the CLI
`cfy plugins bundle-upload`
2. Choose an [basic infrastructure blueprint](https://docs.cloudify.co/latest/trial_getting_started/examples/basic/) and follow the steps to deploy it.
