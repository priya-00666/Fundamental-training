## Lab 4 Objectives
In this lab you will learn about:

* Cloudify Snapshots
* Cloudify Logs
* Cloudify Secrets
* Cloudify Multitenancy


## References for this lab:
* [Cloudify Manager Snapshot](https://docs.cloudify.co/latest/cli/maint_cli/snapshots/)
* [Cloudify Manager Logs](https://docs.cloudify.co/latest/working_with/manager/service-logs/)
* [Cloudify Secrets](https://docs.cloudify.co/latest/cli/orch_cli/secrets/)


### Part 1 - Creating Snapshots
Take a snapshot of your Cloudify manager.
1. Use the UI, go to System Setup -> Snapshots
2. Click `Create`
3. Type in a snapshot id
4. Click `Create`
5. Click the download icon to download the snapshot

<b>Note:</b> CLI use is required for large snapshots.

Your snapshot may be installed on a newly installed manager, clean manager (no resources) using the CLI or UI.

### Part 2 - Cloudify Logs
Download a Cloudify log archive.
<b>Step 1. Create a log bundle:</b>
```
$ cfy log-bundles create
Creating log_bundle log_bundle_CPM804...
Started workflow execution. The execution's id is d60d91b6-a748-4e5f-b4de-fa1a36f7389d.
```
<b>Step 2. Get the log bundle id:</b>
```
$ cfy log-bundles list
Listing log_bundles...

Log bundles:
+-------------------+--------------------------+---------+-------+------------+----------------+------------+
|         id        |        created_at        |  status | error | visibility |  tenant_name   | created_by |
+-------------------+--------------------------+---------+-------+------------+----------------+------------+
| log_bundle_CPM804 | 2022-12-10 17:42:42.911  | created |       |  private   | default_tenant |   admin    |
+-------------------+--------------------------+---------+-------+------------+----------------+------------+
```
<b>Step 3. Download the log bundle:</b>
```
$ cfy log-bundle download log_bundle_CPM804
Downloading log_bundle log_bundle_CPM804...
 log_bundle_CPM804 |###################################################| 100.0%
Log bundle downloaded as log_bundle_CPM804.zip
```
### Part 3 - Cloudify Secrets
You can use the Cloudify Manager secret store for sensitive environment and application details, like user credentials.
Check the secrets help for subcommands and options.
```
$ cfy secrets --help
```
<b>Step 1. Create a secret:</b>
```
$ cfy secrets create my-secret -s SECRET-STRING
The secret called 'my-secret' is stored with value 'SECRET-STRING'
```
<b>Step 2. List secrets:</b>
```
$ cfy secrets list
Listing all secrets...

Secrets:
+-----------------------+--------------------------+--------------------------+------------+----------------+------------+-----------------+
|          key          |        created_at        |        updated_at        | visibility |  tenant_name   | created_by | is_hidden_value |
+-----------------------+--------------------------+--------------------------+------------+----------------+------------+-----------------+
|   aws_access_key_id   | 2022-12-30 02:32:20.708  | 2022-12-18 02:32:20.708  |   tenant   | default_tenant |   admin    |      False      |
|    aws_region_name    | 2022-12-30 02:32:20.729  | 2022-12-18 02:32:20.729  |   tenant   | default_tenant |   admin    |      False      |
| aws_secret_access_key | 2022-12-30 02:32:20.718  | 2022-12-18 02:32:20.718  |   tenant   | default_tenant |   admin    |      False      |
|   default_variables   | 2022-12-30 02:32:20.693  | 2022-12-18 02:32:20.693  |   tenant   | default_tenant |   admin    |      False      |
|       my-secret       | 2023-01-08 17:48:36.469  | 2023-01-20 17:48:36.469  |   tenant   | default_tenant |   admin    |      False      |
+-----------------------+--------------------------+--------------------------+------------+----------------+------------+-----------------+

Showing 5 of 5 secrets
```

You can export your secrets to be imported on a new manager.
<b>Step 3. Export secrets.</b>
```
$ cfy secrets export -p PASSPHRASE
The secrets` file was saved to secrets.json
```
## Part 4 - Multitenancy

Multi-tenancy is a function that enables you to create multiple independent logical groups as isolated environments, which can be managed by a single Cloudify Manager.

A tenant is a logical entity that contains resources, such as blueprints, deployments, plugins and so on.
Using multi-tenancy is useful when you want to limit access to a specific set of data (the tenant) to a defined set of users.

When you install Cloudify, a default tenant, named `default_tenant`, is created.
You can use the default tenant, or create additional tenants, depending on your needs.

<b>Step 1. Create two tenants:</b>

Use the following commands to create tenants:

```
$ cfy tenants create tenant_a
Tenant `tenant_a` created
$ cfy tenants create tenant_b
Tenant `tenant_b` created
```


<b>Step 2. List all tenants:</b>

```
$ cfy tenants list
Listing all tenants...

Tenants:
+----------------+--------+-------+
|      name      | groups | users |
+----------------+--------+-------+
| default_tenant |   0    |   1   |
|    tenant_a    |   0    |   0   |
|    tenant_b    |   0    |   0   |
+----------------+--------+-------+

Showing 3 of 3 tenants
```

<b>Step 3. Create 3 Cloudify users:</b>

```
$ cfy users create user_1 -p password
User `user_1` created with `default` security role
$ cfy users create user_2 -p password
User `user_2` created with `default` security role
$ cfy users create user_3 -p password
User `user_3` created with `default` security role
```

<b>Step 4. Create a group:</b>

```
$ cfy user-groups create group_a
Group `group_a` created
```

<b>Step 5. Assign users to groups</b>

```
$ cfy user-groups add-user -g group_a user_1
User `user_1` added successfully to user group `group_a`
$ cfy user-groups add-user -g group_a user_2
User `user_2` added successfully to user group `group_a`
```

<b>Step 6. Assign users and groups to tenants:</b>

```
$ cfy tenants add-user-group -t tenant_a group_a -r user
User group `group_a` is already associated with tenant `tenant_a`
sh-4.2# cfy tenants add-user -t tenant_b user_3 -r manager
User `user_3` is already associated with tenant `tenant_b`
```
<b>NOTE:</b> `tenant_a` should contain one user group and and two users. `tenant_b` should contain one user, no groups.

```
$ cfy tenants list
Listing all tenants...

Tenants:
+----------------+--------+-------+
|      name      | groups | users |
+----------------+--------+-------+
| default_tenant |        |   1   |
|    tenant_a    |   1    |   2   |
|    tenant_b    |        |   1   |
+----------------+--------+-------+
```

<b>Step 7. Upload a blueprint to a tenant:</b>

```
$ cfy blueprints upload -b mt_lab -t tenant_a ../hello.yaml
```

<b>Step 8. List all blueprints:</b>

```
$ cfy blueprints list
```

The blueprint uploaded to `tenant_a` should not be visible, as you are currently using the tenant `default_tenant`.


<b>Step 9. Login as different user</b>

Let's log in as `user_1`.

```
$ cfy profiles set -u user_1 -p password -t tenant_a
```

<b>Step 10. List all tenants:</b>

```
cfy tenants list
```

You should only see the tenant(s) that `user_1` is allowed to see.
Example output:

```
Listing all tenants...

Tenants:
+----------+--------+-------+
|   name   | groups | users |
+----------+--------+-------+
| tenant_a |   1    |   2   |
+----------+--------+-------+
```

<b>Step 11. Show all blueprints:</b>

```
$ cfy blueprints list
```

You should only see blueprints that belong to this tenant.


<b>Step 12: Attempt accessing disallowed tenant</b>

Try accessing `tenant_b` with `user_1`:

```
$ cfy profiles set -u user_1 -p password -t tenant_b
Setting username to `user_1`
Clearing non-credentials auth
Setting password
Setting tenant to `tenant_b`
Validating credentials...
Credentials validated
Settings saved successfully
An error occurred on the server: 403: User `user_1` is not permitted to perform the action manager_get in the tenant `tenant_b`
```

Note the error, `user_1` is not allowed to access `tenant_b`

<b>Step 13: Login to other tenant:</b>

```
cfy profiles set -u user_3 -p password -t tenant_b
```

<b>Step 14. List tenants:</b>

```
cfy tenants list
Listing all tenants...

Tenants:
+----------+--------+-------+
|   name   | groups | users |
+----------+--------+-------+
| tenant_b |   0    |   1   |
+----------+--------+-------+

Showing 1 of 1 tenants
```

<b>Step 15. Show all blueprints:</b>

```
$ cfy blueprints list
Listing all blueprints...

Blueprints:
+----+-------------+----------------+------------+------------+------------+-------------+------------+-------+-------+--------+
| id | description | main_file_name | created_at | updated_at | visibility | tenant_name | created_by | state | error | labels |
+----+-------------+----------------+------------+------------+------------+-------------+------------+-------+-------+--------+
+----+-------------+----------------+------------+------------+------------+-------------+------------+-------+-------+--------+

Showing 0 of 0 blueprints
```
You should not be able to see any blueprints, because no blueprints exists on
`tenant_b`.
