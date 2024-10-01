ARG GRAFANA_VERSION="latest"

FROM grafana/grafana-oss:${GRAFANA_VERSION}

COPY ./etc/dashboards /etc/dashboards
COPY ./provisioning /etc/grafana/provisioning

USER grafana


EXPOSE 8080