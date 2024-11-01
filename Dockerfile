FROM quay.io/keycloak/keycloak:26.0.4 AS base
WORKDIR /opt/keycloak

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

ENV KC_HTTP_ENABLED=true

### Build phase
FROM base AS build
RUN /opt/keycloak/bin/kc.sh build


### Runtime phase
FROM base
EXPOSE 8080
COPY --from=build /opt/keycloak/ /opt/keycloak/
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]
CMD ["start", "--optimized"]
