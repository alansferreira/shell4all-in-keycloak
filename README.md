# shell4all-in-keycloak
Simple interface to keycloak apis based on shell script.

## Usage

### Configurarion

### Keycloak instance and realm must have an `client_id` configured as:
* `Access Type` as "**confidential**"
* `Standard Flow Enabled` **off**
* `Service Accounts Enabled` **on**
* `Service Account Roles` **create-client**, **manage-clients**, **query-clients** and **view-clients** from `master-relm` client roles

### Fill your keycloak instance parameters on `.env` file.

```sh
export ENV='dev'

export KC_CLIENT_ID=${KC_CLIENT_ID-"shell4all-keycloak"}
export KC_CLIENT_SECRET=${KC_CLIENT_SECRET-"HT8Tz3D418M5I4VrWK77w2yUupXiwv08"}

export REALM=${REALM-"master"}
export KC_INSTANCE_URL=${INSTANCE_URL_BASE-"http://localhost:8080"}
export KC_REALM_URL=${KC_INSTANCE_URL}/auth/admin/realms/${REALM}

```

### Make sure that scripts have **execution permissions** `chmod +x kc-*`

```sh
chmod +x kc-*
```

```console
$ kc-client-add "my-client-id"
http://localhost:8080/auth/admin/realms/master/clients/ea4e833d-2b10-4fd9-b5e2-059a30006326

$ kc-client-edit "ea4e833d-2b10-4fd9-b5e2-059a30006326" "{ \"description\": \"my client description\"}"

$ kc-client-query "my-client-"
[{ "id": "ea4e833d-2b10-4fd9-b5e2-059a30006326", "clientId": "my-client-id", "description": "my client description"}]

$ kc-client-del "ea4e833d-2b10-4fd9-b5e2-059a30006326"

```

## Releasing

This project has configured to use **git-mkver** to version bumps base on **conventional commits** standards, just run `./release` when version is ready to release.

## Testing

You can use `docker-compose.yaml` to **e2e** tests.

Tests are based on `bash_unit`.

```console
$ cd src
$ ./bash_unit -r *-test
Running tests in kc-client-add-test
        Running test_add_new_client ... SUCCESS ✓ 
Running tests in kc-client-del-test
        Running test_delete_client_by_url ... SUCCESS ✓ 
        Running test_delete_client_by_uuid ... SUCCESS ✓ 
Running tests in kc-client-edit-test
        Running test_edit_client ... SUCCESS ✓ 
Running tests in kc-client-query-test
        Running test_should_print_query_with_max_2_values ... SUCCESS ✓ 
        Running test_should_print_query_with_default_values ... SUCCESS ✓ 
Running tests in kc-client-role-add-test
        Running test_add_new_role_with_minimal_data ... SUCCESS ✓ 
        Running test_add_new_role_with_complex_data ... SUCCESS ✓ 
Running tests in kc-client-role-del-test
        Running test_delete_role_by_uuid ... SUCCESS ✓ 
Running tests in kc-client-role-query-test
        Running test_should_print_query_with_default_values ... SUCCESS ✓ 
        Running test_should_print_query_with_max_2_values ... SUCCESS ✓ 
Overall result: SUCCESS ✓ 

$
```