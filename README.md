# mhnet Keycloak

## Configuration

```sh

KC_BOOTSTRAP_ADMIN_PASSWORD=XXX
KC_BOOTSTRAP_ADMIN_USERNAME=XXX
KC_DB_URL=postgres://keycloak:xxx@xxx:5432/keycloak
KC_HOSTNAME=https://xxx
KC_HOSTNAME_ADMIN=https://xxx
```

## CI/CD

Note that when using the provided `GITHUB_TOKEN`, (new pushes will not trigger workflow runs)[https://stackoverflow.com/a/75348554/405454]. To work around this, we use a PAT instead.

The PAT must be provided as a [Repository secret](https://github.com/mhutter/mhnet-keycloak/settings/secrets/actions) named `PAT`.

Get from: https://github.com/settings/personal-access-tokens

Required permissions:

- `Contents: Read and write`
