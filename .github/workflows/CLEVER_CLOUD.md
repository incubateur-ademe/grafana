# Deployment

## Setup

Deploy a Docker application with a PostgreSQL database on your platform of choice.

### Environment variables

* `FGP_KEY_FR1`: [GENERATED] _(FGP key for osc-fr1 Scalingo API)_
* `FGP_BLOB_FR1`: [GENERATED] _(FGP blob for osc-fr1 Scalingo API)_
* `FGP_KEY_SECNUM`: [GENERATED] _(FGP key for osc-secnum-fr1 Scalingo API)_
* `FGP_BLOB_SECNUM`: [GENERATED] _(FGP blob for osc-secnum-fr1 Scalingo API)_
* `GF_INSTALL_PLUGINS`: `yesoreyeram-infinity-datasource, volkovlabs-variable-panel, marcusolsson-dynamictext-panel`
* `GF_PANELS_DISABLE_SANITIZE_HTML`: `true` _(for `marcusolsson-dynamictext-panel` plugin)_
* `GF_PLUGINS_PLUGIN_ADMIN_ENABLED`: `true`
* `GF_PUBLIC_DASHBOARDS_ENABLED`: `false`
* `GF_DATABASE_URL`: [GENERATED] _(PostgreSQL connection URL)_
* `GF_SERVER_DOMAIN`: [GENERATED] _(your configured domain)_
* `GF_SERVER_HTTP_PORT`: `8080`
* `GF_SERVER_PROTOCOL`: `http` _(https handled by reverse proxy)_
* `GF_USERS_ALLOW_ORG_CREATE`: `false`
