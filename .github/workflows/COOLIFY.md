# Coolify deployment

## Setup

### Coolify interface

Create 1 Service (one-click Grafana with PostgreSQL) or deploy via Docker Compose.

Set the destination (Docker network) before creating resources.

### Plugins

Plugins are installed via the `GF_INSTALL_PLUGINS` env var at container startup.

### Database restore (optional)

If migrating from an existing instance, restore the PG dump:

```bash
# Copy dump to server
scp grafana.dump <server>:/tmp/

# Copy into PG container
docker cp /tmp/grafana.dump <pg_container>:/tmp/

# Restore
docker exec -it <pg_container> pg_restore --no-owner --clean --if-exists \
  -U <POSTGRES_USER> -d grafana /tmp/grafana.dump
```

### Environment variables

* `FGP_KEY_FR1`: [GENERATED] _(FGP key for osc-fr1 Scalingo API)_
* `FGP_BLOB_FR1`: [GENERATED] _(FGP blob for osc-fr1 Scalingo API)_
* `FGP_KEY_SECNUM`: [GENERATED] _(FGP key for osc-secnum-fr1 Scalingo API)_
* `FGP_BLOB_SECNUM`: [GENERATED] _(FGP blob for osc-secnum-fr1 Scalingo API)_
* `GF_INSTALL_PLUGINS`: `yesoreyeram-infinity-datasource, volkovlabs-variable-panel, marcusolsson-dynamictext-panel`
* `GF_PANELS_DISABLE_SANITIZE_HTML`: `true` _(for `marcusolsson-dynamictext-panel` plugin)_
* `GF_PLUGINS_PLUGIN_ADMIN_ENABLED`: `true`
* `GF_PUBLIC_DASHBOARDS_ENABLED`: `false`
* `GF_DATABASE_URL`: [GENERATED] _(internal PostgreSQL URL from Coolify)_
* `GF_SERVER_DOMAIN`: [GENERATED] _(your configured domain, e.g. `grafana.incubateur.ademe.fr`)_
* `GF_SERVER_HTTP_PORT`: `3000`
* `GF_SERVER_PROTOCOL`: `http` _(https handled by Traefik)_
* `GF_USERS_ALLOW_ORG_CREATE`: `false`

### Domain & SSL

Configure the domain in the Grafana service settings on Coolify. Traefik handles Let's Encrypt certificate generation automatically.
