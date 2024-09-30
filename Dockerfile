ARG GRAFANA_VERSION="latest"

FROM grafana/grafana-oss:${GRAFANA_VERSION}
ARG GF_GID="0"

ENV GF_PATHS_PLUGINS="/var/lib/grafana-plugins"
ENV GF_PLUGIN_RENDERING_CHROME_BIN="/usr/bin/chrome"


COPY ./grafana.ini /etc/grafana/grafana.ini
COPY ./etc/dashboards /etc/dashboards
COPY ./provisioning /etc/grafana/provisioning

USER root

RUN mkdir -p "$GF_PATHS_PLUGINS" && \
    chown -R grafana:${GF_GID} "$GF_PATHS_PLUGINS"

USER grafana

ARG GF_INSTALL_PLUGINS="yesoreyeram-infinity-datasource, volkovlabs-variable-panel, marcusolsson-dynamictext-panel"

RUN if [ ! -z "${GF_INSTALL_PLUGINS}" ]; then \
    OLDIFS=$IFS; \
    IFS=','; \
    set -e ; \
    for plugin in ${GF_INSTALL_PLUGINS}; do \
    IFS=$OLDIFS; \
    if expr match "$plugin" '.*\;.*'; then \
    pluginUrl=$(echo "$plugin" | cut -d';' -f 1); \
    pluginInstallFolder=$(echo "$plugin" | cut -d';' -f 2); \
    grafana-cli --pluginUrl ${pluginUrl} --pluginsDir "${GF_PATHS_PLUGINS}" plugins install "${pluginInstallFolder}"; \
    else \
    grafana-cli --pluginsDir "${GF_PATHS_PLUGINS}" plugins install ${plugin}; \
    fi \
    done \
    fi

EXPOSE 8080