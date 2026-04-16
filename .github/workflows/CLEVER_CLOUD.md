# Clever Cloud deployment

## Setup

### Clever Cloud interface

Create 1 Docker application with the `XS` plan:
* `grafana`

And 1 PostgreSQL database (version 15) with any plan that you will bind to the app accordingly.

_(depending on when you created those addons, don't forget to bind them to the appropriate application)_

Now set for the app these options:
* Zero downtime deployment
* Cancel ongoing deployment on new push
* Force HTTPS

and connect Clever Cloud to your GitHub repository.

Adjust the domain names as you want, and configure the environment variables as follow:
* `FGP_KEY_FR1`: [GENERATED] _(FGP key for osc-fr1 Scalingo API)_
* `FGP_BLOB_FR1`: [GENERATED] _(FGP blob for osc-fr1 Scalingo API)_
* `FGP_KEY_SECNUM`: [GENERATED] _(FGP key for osc-secnum-fr1 Scalingo API)_
* `FGP_BLOB_SECNUM`: [GENERATED] _(FGP blob for osc-secnum-fr1 Scalingo API)_
* `GF_INSTALL_PLUGINS`: `yesoreyeram-infinity-datasource, volkovlabs-variable-panel, marcusolsson-dynamictext-panel`
* `GF_PANELS_DISABLE_SANITIZE_HTML`: `true` _(for `marcusolsson-dynamictext-panel` plugin)_
* `GF_PLUGINS_PLUGIN_ADMIN_ENABLED`: `true`
* `GF_PUBLIC_DASHBOARDS_ENABLED`: `false`
* `GF_DATABASE_MAX_OPEN_CONN`: `1` _(only when using DEV plan on pg addon, to avoid `too many clients` error)_
* `GF_DATABASE_SSL_MODE`: `require`
* `GF_DATABASE_URL`: [GENERATED] _(provided by the interface, must start with "postgres" instead of "postgresql")_
* `GF_SERVER_DOMAIN`: [GENERATED] _(either your configured domain, or the cleverapp.io one provided by the interface)_
* `GF_SERVER_HTTP_PORT`: `8080`
* `GF_SERVER_PROTOCOL`: `http` _(https mode is handled by Clever Cloud by default)_
* `GF_USERS_ALLOW_ORG_CREATE`: `false`
