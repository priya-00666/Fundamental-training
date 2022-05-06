## Getting Started
Create and start your lab environment:

1. Connect to the VPN (optional)
2. Install the CLI on the CLI VM #optional
3. After each lab clean the system - delete deployment and blueprints
4. Upload the following plugins to the manager: 
* OpenStackV3
* Utilities

###Part 1 - Scale a simple node
1. SSH to your Conductor VM
2. Install blueprint.yaml. It contains a single node, which stores a hello message in its runtime_properties.
3. Run the scale workflow and increase the number of instances to 3 (use delta parameter).
4. Check all node instances’ runtime properties - they should contain different node instance id in the hello message.
5. Run scale workflow again, but this time, decrease the number of instances to 2. Check the results.
6. Keep the deployment running.
###Part 2 - Run deployment update
1. Add another cloudify.nodes.Root node to your blueprint - it doesn’t have to perform any tasks. Connect it to the original node using the cloudify.relationships.connected_to relationship.
2. Upload the updated blueprint with a different name.
3. Open the deployment update page in the original deployment.
4. As the blueprint input, choose your updated blueprint. Then, hit the Preview button to see what will be changed.
5. Then hit the Update button and see the results. Your deployment now should contain two nodes connected with each other.


