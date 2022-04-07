##Lab 5 - Service Composition

### Lab 5 Objectives
In this lab you will learn how use the Cloudify CLI to:
* Blueprint imports
* Service Composition - Namespaces
* Service Composition - Components

### References for this lab: 
* [Blueprint documenation - imports](https://docs.cloudify.co/latest/developer/blueprints/spec-imports/)
* [Service Composition - Namespaces](https://docs.cloudify.co/latest/developer/blueprints/spec-imports/#namespace-value-validations)
* [Service Composition - Shared Resources](https://docs.cloudify.co/latest/working_with/service_composition/shared-resource/)

## Getting Started
* Connect to the VPN (optional)
* Install the CLI on the CLI VM
* After each lab clean the system - delete deployment and blueprints
* Upload the following plugins to the manager:
  * [OpenStackV3](https://github.com/cloudify-cosmo/cloudify-openstack-plugin/releases/tag/3.3.2)
  * [Utilities](https://github.com/cloudify-incubator/cloudify-utilities-plugin/releases/tag/1.25.6)

### Part 1 - Imports
* Use blueprint-osp-vm-full.yaml
* update the blueprint to use a custom type for the server host
* Declare the custom type for the server in a separate yaml file
* Import the custom server type into the main blueprint: `blueprint-osp-vm-full.yaml`

### Part 2 - Namespaces
* Use blueprint-osp-vm-full.yaml 
* Separate it into `Networking` and `VM` files
* Use namespaces to compose the blueprints together

### Part 3 - Components
* Use `blueprint-osp-vm-full.yaml` as a shared resource component to initialize the VM 
* Create a blueprint that will install an application on the VM

###Solutions
Solutions can be found in the solutions folder of this repository.
