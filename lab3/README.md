## Lab 3 Objectives
In this lab you will learn about:
* Runtime properties
* Deployment outputs
* Custom node types
* Custom relationships


## References for this lab: 
* Previous lab instructions and materials
* [Blueprints - node types](https://conductor.windriver.com/docs/22.03/developer/blueprints/spec-node-types/)
* [Blueprints - relationships](https://conductor.windriver.com/docs/22.03/developer/blueprints/spec-relationships/)
* [Blueprints - interfaces](https://conductor.windriver.com/docs/22.03/developer/blueprints/spec-interfaces/)


## Getting Started
Create and start your lab environment:

1. Connect to the VPN (optional)
2. Install the CLI on the CLI VM
3. After each lab clean the system - delete deployment and blueprints
4. Upload the following plugins to the manager: 
* OpenStackV3
* Utilities
5. Install the openstack-example-network.yaml (with `openstack-example-network` as the deployment name)

### Part 1 - Runtime Properties
1. Deploy blueprint-osp-vm-full.yaml. using the UI (hint: check the blueprint for required resources)
2. Find the host ip address in the runtime properties using the UI
2. Find the floating ip Address in the runtime properties using the UI

### Part 2 - Outputs 
1. Edit the blueprint-osp-vm-full.yaml
2. Create the following outputs
* IP addresses of the server node
* Floating IP addresses
* Flavor and image used for the node
* Openstack tenant name

### Part 3 - Custom types
Using your blueprint from Part 2:
1. Define a custom type for a server extending the openstack plugin server
2. Update the topology to have 2 node templates of the custom type
3. Create new port and floating ip address for the 2nd server and set the relationships

### Part 4 - Custom Relationships
Use the blueprint from Part 3:
1. Define a custom relationship with an interface that will create file with date on the host
2. Create 2 Application nodes one contained on each server
3. Connect the 2 application nodes with the custom relationship

### Optional Part 5 - Writing blueprint
1. Use the blueprint-osp-vm-full.yaml for reference to create a blueprint from scratch
2. The blueprint should have 2 VMs
3. Install Database mysql/mariaDB and Application Server apache
4. Via relationship put the IP of the DB server on the welcome page of the Apache Node
5. The output of the application should contain the IP of the DB and a URL to the web server

## Appendix - Example and Solutions
Application node template example
```
  application:
    type: cloudify.nodes.ApplicationModule
    relationships:
      - type: cloudify.relationships.contained_in
        target: host
```

Custom Relationship Example
```
relationships:
  relationship.my_connected_to:
    derived_from: cloudify.relationships.connected_to
    source_interfaces:
      cloudify.interfaces.relationship_lifecycle:
        establish: scripts/script.sh
    target_interfaces:
      cloudify.interfaces.relationship_lifecycle:
        establish: scripts/script.sh
```
### Solutions
Solutions for labs 3 and 4 can be found in the solutions folder of the fundamentals-training repo.
