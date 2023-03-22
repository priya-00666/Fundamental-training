## Lab 5 Objectives
In this lab you will learn how to:
* Create and use a custom node type definition
* Install agents
* Running scripts on remote compute nodes
* Using Cloudify ctx

In this exercise please modify hello.yaml and it's associated resources to separate the compute and application resources. And allow it to run on a remote VM (CLI VM from the exercises can be used).

## References for this lab:
* [Documentation - custom node types](https://docs.cloudify.co/latest/developer/blueprints/spec-node-types/)
* [Documentation - interfaces](https://docs.cloudify.co/latest/developer/blueprints/spec-interfaces/)
* [Documentation - agents](https://docs.cloudify.co/latest/cloudify_manager/agents/installation/)
* [Documentation - Cloudify ctx](https://docs.cloudify.co/latest/developer/writing_plugins/creating-your-own-plugin/#retrieving-node-properties)

## To run the simple, low-python version of the solution
```
cfy install -b hello2 -d hello2 hello2.yaml
Uploading blueprint hello2.yaml...
hello2.yaml |#########################################################| 100.0%
Blueprint `hello2` upload started.
2023-03-22 21:49:05.595  CFY <None> Starting 'upload_blueprint' workflow execution
2023-03-22 21:49:05.698  LOG <None> INFO: Blueprint archive uploaded. Extracting...
2023-03-22 21:49:05.850  LOG <None> INFO: Blueprint archive extracted. Parsing...
2023-03-22 21:49:07.563  LOG <None> INFO: Blueprint parsed. Updating DB with blueprint plan.
2023-03-22 21:49:08.255  CFY <None> 'upload_blueprint' workflow execution succeeded
Blueprint uploaded. The blueprint's id is hello2
Creating new deployment from blueprint hello2...
Deployment `hello2` created. The deployment's id is hello2
Executing workflow `install` on deployment `hello2` [timeout=900 seconds]
2023-03-22 21:49:16.862  CFY <hello2> Starting 'install' workflow execution
2023-03-22 21:49:17.111  CFY <hello2> Subgraph started 'install_new_http_web_server_ir89oy'
2023-03-22 21:49:17.255  CFY <hello2> [new_http_web_server_ir89oy] Validating node instance before creation: nothing to do
2023-03-22 21:49:17.999  CFY <hello2> [new_http_web_server_ir89oy] Precreating node instance: nothing to do
2023-03-22 21:49:18.145  CFY <hello2> [new_http_web_server_ir89oy] Creating node instance: nothing to do
2023-03-22 21:49:18.290  CFY <hello2> [new_http_web_server_ir89oy] Configuring node instance: nothing to do
2023-03-22 21:49:18.379  CFY <hello2> [new_http_web_server_ir89oy] Starting node instance: nothing to do
2023-03-22 21:49:18.489  CFY <hello2> [new_http_web_server_ir89oy] Creating agent
2023-03-22 21:49:18.589  CFY <hello2> [new_http_web_server_ir89oy.create] Sending task 'cloudify_agent.installer.operations.create'
2023-03-22 21:49:20.879  CFY <hello2> [new_http_web_server_ir89oy.create] Task started 'cloudify_agent.installer.operations.create'
2023-03-22 21:49:26.534  LOG <hello2> [new_http_web_server_ir89oy.create] INFO: Creating Agent new_http_web_server_ir89oy
2023-03-22 21:49:38.389  LOG <hello2> [new_http_web_server_ir89oy.create] INFO: Agent created, configured and started successfully
2023-03-22 21:49:38.791  CFY <hello2> [new_http_web_server_ir89oy.create] Task succeeded 'cloudify_agent.installer.operations.create'
2023-03-22 21:49:38.842  CFY <hello2> [new_http_web_server_ir89oy] Agent created
2023-03-22 21:49:38.889  CFY <hello2> [new_http_web_server_ir89oy] Poststarting node instance: nothing to do
2023-03-22 21:49:38.948  CFY <hello2> [new_http_web_server_ir89oy] Node instance started
2023-03-22 21:49:39.013  CFY <hello2> Subgraph succeeded 'install_new_http_web_server_ir89oy'
2023-03-22 21:49:39.057  CFY <hello2> Subgraph started 'install_web-app_8ihddy'
2023-03-22 21:49:39.193  CFY <hello2> [web-app_8ihddy] Validating node instance before creation: nothing to do
2023-03-22 21:49:39.235  CFY <hello2> [web-app_8ihddy] Precreating node instance: nothing to do
2023-03-22 21:49:39.279  CFY <hello2> [web-app_8ihddy] Creating node instance: nothing to do
2023-03-22 21:49:39.318  CFY <hello2> [web-app_8ihddy] Configuring node instance: nothing to do
2023-03-22 21:49:39.370  CFY <hello2> [web-app_8ihddy] Starting node instance
2023-03-22 21:49:39.453  CFY <hello2> [web-app_8ihddy.start] Sending task 'script_runner.tasks.run'
2023-03-22 21:49:41.141  LOG <hello2> [web-app_8ihddy.start] INFO: Downloaded hello-resources/install2.py to /tmp/IYWEH/install2.py
2023-03-22 21:49:41.272  LOG <hello2> [web-app_8ihddy.start] INFO: hello from cloudify on X.X.X.X:8000
2023-03-22 21:49:41.427  CFY <hello2> [web-app_8ihddy.start] Task succeeded 'script_runner.tasks.run'
2023-03-22 21:49:41.474  CFY <hello2> [web-app_8ihddy] Poststarting node instance: nothing to do
2023-03-22 21:49:41.521  CFY <hello2> [web-app_8ihddy] Node instance started
2023-03-22 21:49:41.581  CFY <hello2> Subgraph succeeded 'install_web-app_8ihddy'
2023-03-22 21:49:41.838  CFY <hello2> 'install' workflow execution succeeded
Finished executing workflow install on deployment hello2
```
##Next Steps
Break the blueprint into components. Remember, you can use capabilities to make properties/attributes available to other deployments.
[Service Composition Documentation](https://docs.cloudify.co/latest/working_with/service_composition/)
