# Clever Cloud deployment

## Setup

### Clever Cloud interface

Create 1 Docker applications with the `XS` plan:
* `grafana`

And 1 PostgreSQL databases (version 15) with any plan that you will binding to each app accordingly:
* `grafana`

_(depending on when you created those addonds, don't forget to bind them to the appropriate application)_

Now set for the app these options:
* Zero downtime deployment
* Cancel ongoing deployment on new push
* Force HTTPS

and connect Clever Cloud to your GitHub repository.

Adjust the domain names as you want, and configure the environment variables as follow:
* `SCALINGO_AUTH_TOKEN`: [GENERATED] _(can be retrieved from Scalingo token. It's not a bearer!)_
* `GF_INSTALL_PLUGINS`: `yesoreyeram-infinity-datasource, volkovlabs-variable-panel, marcusolsson-dynamictext-panel`
* `GF_PANELS_DISABLE_SANITIZE_HTML`: `true` _(to avoid sanitizing HTML in panels, for `marcusolsson-dynamictext-panel` plugin)_
* `GF_PLUGINS_PLUGIN_ADMIN_ENABLED`: `true`
* `GF_PUBLIC_DASHBOARDS_ENABLED`: `false`
* `GF_DATABASE_MAX_OPEN_CONN`: `1` _(only when using DEV plan on pg addon, to avoid `too many clients` error)_
* `GF_DATABASE_SSL_MODE`: `require`
* `GF_DATABASE_URL`: [GENERATED] _(provided by the interface, must start with "postgres" instead of "postgresql")_
* `GF_SERVER_DOMAIN`: [GENERATED] _(either your configured domain, or the cleverapp.io one provided by the interface)_
* `GF_SERVER_HTTP_PORT`: `8080`
* `GF_SERVER_PROTOCOL`: `http` _(https mode is handled by clevercloud by default)_
* `GF_USERS_ALLOW_ORG_CREATE`: `false`

