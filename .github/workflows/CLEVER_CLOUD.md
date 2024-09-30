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

Adjust the domain names as you want, and configure the environment variables as follow:
* `SCALINGO_AUTH_TOKEN`: [GENERATED] _(can be retrieved from Scalingo token. It's not a bearer!)_
* `GF_INSTALL_PLUGINS`: `yesoreyeram-infinity-datasource, volkovlabs-variable-panel, marcusolsson-dynamictext-panel`
* `GF_PANELS_DISABLE_SANITIZE_HTML`: `true`
* `GF_PLUGINS_PLUGIN_ADMIN_ENABLED`: `true`
* `GF_PUBLIC_DASHBOARDS_ENABLED`: `false`
* `GF_DATABASE_MAX_OPEN_CONN`: `1` _(only when using DEV plan on pg addon, to avoid `too many clients` error)_
* `GF_DATABASE_TYPE`: `postgres`
* `GF_DATABASE_HOST`: [GENERATED] _(provided by the interface)_
* `GF_DATABASE_NAME`: [GENERATED] _(provided by the interface)_
* `GF_DATABASE_USER`: [GENERATED] _(provided by the interface)_
* `GF_DATABASE_PASSWORD`: [GENERATED] _(provided by the interface)_
* `GF_DATABASE_URL`: [GENERATED] _(provided by the interface)_
* `GF_SERVER_DOMAIN`: [GENERATED] _(either your configured domain, or the cleverapp.io one provided by the interface)_
* `GF_INSTANCE_NAME`: `Grafana` _(or any other name you want)_

### GitHub interface

#### GitHub Actions

Configure the following repository secrets (not environment ones):

- `CLEVER_APP_ID`: [GENERATED] _(format `app_{uuid}`, can be retrieved into the Clever Cloud interface)_
- `CLEVER_TOKEN`: [GENERATED] _(can be retrieved from `clever login`, but be warned it gives wide access)_
- `CLEVER_SECRET`: [GENERATED] _(can be retrieved from `clever login`, but be warned it gives wide access)_

## Upgrade Vaultwarden version

1. Synchronize your fork with the original repository
2. Search for the specific commit representing the wanted version
3. Rebase your `deploy` branche to it while making sure to not take third-party files into `.github`. Make also sure to keep local changes in `Cargo.toml`
4. Force-push the branch