## Lab 4 Objectives
In this lab you will learn about:
* Installing a Cloudify manager
* Uploading a license
* Creating a snapshot
* Restoring a snapshot
* Cloudify logs
* Exporting secrets


## References for this lab: 
* [Cloudify manager installation prerequisites](https://docs.cloudify.co/latest/install_maintain/installation/prerequisites/)
* [Cloudify Manager Installation](https://docs.cloudify.co/latest/install_maintain/installation/installing-manager/)
* [Cloudify Manager License](https://docs.cloudify.co/latest/install_maintain/installation/manager-license/)
* [Cloudify Manager Snapshot](https://docs.cloudify.co/latest/cli/maint_cli/snapshots/)
* [Cloudify Manager Logs](https://docs.cloudify.co/latest/working_with/manager/service-logs/)
* [Cloudify Secrets](https://docs.cloudify.co/latest/cli/orch_cli/secrets/)
* Note: In order to use the CLI snapshots and logs you will need to configure the CLI profile with the manager SSH credentials.
```
$ cfy profiles set -s centos -k ~/.ssh/training.rsa
Validating credentials...
Credentials validated
Setting ssh user to `centos`
Setting ssh key to `/home/centos/.ssh/training.rsa`
Settings saved successfully
```
### Part 1 - Installing a Cloudify Manager

Install an AIO (All in One) manager:
1. SSH to APP1 VM (IP, user and key are found in the Lab Dashboard)
2. `>sudo yum install RPM` (link provided by instructor)
3. `>cfy_manager install --private-ip APP1-PRIVATE_IP --public-ip APP1-PUBLIC_IP --admin-password STRONG-PASSWORD`
4. Check that the manager is healthy: `cfy status`

### Part 2 - Uploading a Cloudify license
The license can be uploaded via the UI or CLI. For CLI:
* `cfy license upload /PATH/license.yaml` (license file provided by instructor)

### Part 3 - Creating Snapshots
Take a snapshot of the pre-installed Cloudify manager.
1. Use the UI, go to System Setup -> Snapshots
2. Click `Create`
3. Type in a snapshot id
4. Click `Create`
5. Click the download icon to download the snapshot 

Note: CLI use is required for large snapshots.

### Part 4 - Restoring Snapshots
Restore your snapshot on the newly installed manager on App1 VM. The snapshot can be restored on a clean manager (no resources) using the CLI or UI. For CLI:
1. Copy the snapshot archive to the App1 VM. 
* `scp -i /PATH/training.rsa snapshot.zip centos@APP1-VM:. `
2. SSH to App1 VM
3. Upload the snapshot `cfy snapshot upload /PATH/snapshot.zip`

```
$ cfy snapshot upload snap.zip
Uploading snapshot snap.zip...
 snap.zip |############################################################| 100.0%
Snapshot uploaded. The snapshot's id is snapshot_RACJUM
```

4. Restore the snapshot using the snapshot id returned by the upload command.
```
$ cfy snapshot restore snapshot_RACJUM
Restoring snapshot snapshot_RACJUM...
Started workflow execution. The execution's id is 27d649b7-a60a-45af-99c6-3ad82dfb35a0. You can use `cfy snapshots status` to check for the restore status.
```


### Part 5 - Cloudify Logs
Download a Cloudify log archive.
```
$ cfy logs download
Creating logs archive in manager: /tmp/cloudify-manager-logs_20220406T002146_10.154.0.3.tar.gz
Downloading archive to: /home/centos/cloudify-manager-logs_20220406T002146_10.154.0.3.tar.gz
Removing archive from host...
```
### Part 6 - Export Cloudify Secrets
You can export your secrets to be imported on a new manager. 
```
$ cfy secrets export -p PASSPHRASE
The secrets` file was saved to secrets.json
```
