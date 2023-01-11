# shell4all-in-keycloak
Simple interface to keycloak apis based on shell script.

## Usage

> First fill your keycloak instance parameters on `.env` file.

> Make sure that scripts have **execution permissions** `chmod +x kc-client-*`


```console
$ kc-client-add "my-client-id"
http://localhost:8080/auth/admin/realms/master/clients/ea4e833d-2b10-4fd9-b5e2-059a30006326

$ kc-client-edit "ea4e833d-2b10-4fd9-b5e2-059a30006326" "{ \"description\": \"my client description\"}"

$ kc-client-query "my-client-"
[{ "id": "ea4e833d-2b10-4fd9-b5e2-059a30006326", "clientId": "my-client-id", "description": "my client description"}]

$ kc-client-del "ea4e833d-2b10-4fd9-b5e2-059a30006326"

```

### Releasing

Just run `.make` to dump all in one.

### Testing

You can use `docker-compose.yaml` to e2e tests.

Tests are based on `bash_unit`

```console
$ bash_unit -r src/*-test
```