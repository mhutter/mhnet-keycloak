FROM quay.io/keycloak/keycloak:26.1.4 AS base

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

### Build phase
FROM base AS build
WORKDIR /opt/keycloak
RUN /opt/keycloak/bin/kc.sh build


### Runtime phase
FROM base
EXPOSE 8443
COPY --from=build /opt/keycloak/ /opt/keycloak/
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized"]
