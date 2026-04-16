# Grafana — Monitoring Scalingo

Dashboards Grafana pour le monitoring des applications Scalingo de l'incubateur ADEME.

## Dashboards

- **App Detail** — Vue consolidée par app : Router (2XX/4XX/5XX), CPU, Memory/Swap. Switch entre les régions osc-fr1 et osc-secnum-fr1 via un dropdown.
- **Router** / **Router (SecNum)** — Stats router HTTP par app (legacy, remplacés par App Detail).
- **Memory / Swap** / **Memory / Swap (SecNum)** — Métriques mémoire par app (legacy, remplacés par App Detail).

## Architecture

Les datasources utilisent [Fine-Grained Proxy (FGP)](https://github.com/incubateur-ademe/fine-grained-proxy) pour accéder à l'API Scalingo avec des tokens scopés en lecture seule. Grafana n'a pas accès au token Scalingo directement.

```
Grafana → FGP (X-FGP-Key + X-FGP-Blob) → Scalingo API
```

## Configuration FGP

Générer 2 URLs FGP (une par région Scalingo) sur votre instance FGP :

| Paramètre | Valeur |
|---|---|
| **Target** (osc-fr1) | `https://api.osc-fr1.scalingo.com` |
| **Target** (osc-secnum-fr1) | `https://api.osc-secnum-fr1.scalingo.com` |
| **Auth mode** | `scalingo-exchange` |
| **TTL** | `0` (pas d'expiration) |
| **Scopes** | `GET:/v1/apps`, `GET:/v1/apps/*/stats/*`, `GET:/v1/apps/*/router_logs/*` |

Les scopes limitent l'accès en lecture seule aux endpoints de listing d'apps et de métriques (CPU, mémoire, swap, router).

Chaque URL générée fournit un **blob** et une **key** à renseigner dans les env vars correspondantes.

## Développement local

```bash
docker compose up
```

Grafana est accessible sur http://localhost:3000. Les env vars FGP doivent être définies (voir [deployment](.github/workflows/CLEVER_CLOUD.md)).

## Plugins requis

- `yesoreyeram-infinity-datasource` — Requêtes JSON vers les APIs Scalingo via FGP
- `volkovlabs-variable-panel` — Dropdowns custom
- `marcusolsson-dynamictext-panel` — Panels HTML dynamiques
