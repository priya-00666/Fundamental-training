## Getting Started
Create and start your lab environment: 
1. Connect to the VPN (optional)
2. Install the CLI on the CLI VM 
3. After each lab clean the system - delete deployment and blueprints
### Part 1 - YAML drill
Create a yaml file that contains the following elements and validate it:
A dictionary with 2 keys: hostnames and content
The key ‘hostnames’ value is a list of: app, data and proxy
The key ‘content‘ value is a list of: node.js, mysql and nginx 
Find an online YAML validator and validate your file.
### Part 2 - modifying a basic blueprint
1. SSH to your training CLI VM
2. Clone this repository
3. Using the UI, create a new secret "training_agent_key_private" 
(key file is found on the lab dashboard) 
3. Edit the file basic.yaml
Replace the string `REPLACE_WITH_IP_ADDRESS` with your App1 VM IP
(Found on the labs dashboard)
4. Upload the blueprint to cloudify manager and create a deployment from it via cli
Run the install workflow
Examine the logs and make sure that all interfaces have been executed
Clean the environment (uninstall, delete deployment and blueprint)
### Part 3 - Simple openstack Blueprint
1. Upload the openstack V3 plugin to your manager
2. Upload the blueprint-osp-vm.yaml as blueprint-osp-vm
3. Create a deployment blueprint-osp-vm
4. Run the install workflow
5. Check the Iaas for the created VM
6. Create a new deployment using the blueprint-osp-vm (remember the new deployment will need a unique name, also change the inputs to give your server a different name)
7. Inspect the server node and node-instances
8. Uninstall and delete your two deployments
9. Create a copy of the blueprint-osp-vm.yaml file and open it in an editor
10. Eliminate the Inputs section by hard coding the inputs values into  the the nodes
11. Upload and test the blueprint
12. Extend the blueprint to provision 2 servers
13. Upload and test the expanded blueprint
### Part 4 - Introduction to relationships
Based on your updated blueprint-osp-vm (two servers) from previous section:
1. Update the blueprint so one of the servers has a depends_on relationship to the other
2. Inspect the installation process
### Additional Optional Exercises 
Part 5 - Update basic blueprint
Based on basic.yaml blueprint (from Part 2): 
1. Update the blueprint to have 2 applications in the same host (use the same lifecycle interfaces)
2. Deploy the blueprint and test
3. Clean the environmnet
### Part 6 - Relationships Introduction
Based on previous exercise, modify the bluerpint: 
1. Add a connected_to relationship between the 2 applications
2. Deploy the blueprint and test
3. Clean the environment

### Reference: Application node example
application_one:
      type: cloudify.nodes.ApplicationModule
      relationships:
        - target: server1
          type: cloudify.relationships.contained_in
