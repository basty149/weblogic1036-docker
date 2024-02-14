FROM debian:11-slim as build
LABEL org.opencontainers.image.authors="Sébastien L. basyt149@gmail.com"

RUN groupadd -g 1001 weblogic && \
    useradd -u 1001 -g weblogic weblogic && \
    mkdir /u01 && \
    chown -R weblogic. /u01

COPY --chown=weblogic:weblogic --chmod=0755 u01/ /u01/

USER weblogic

ENV USER_MEM_ARGS="-Djava.security.egd=file:/dev/./urandom"

RUN cd /u01/install && \
    /u01/install/install_weblogic1036.sh && \
    rm -f /u01/install/*

FROM debian:11-slim as main
LABEL org.opencontainers.image.authors="Sébastien L. basyt149@gmail.com"

RUN groupadd -g 1001 weblogic && \
    useradd -u 1001 -g weblogic weblogic

COPY --from=build --chown=weblogic:weblogic --chmod=0755 u01/ /u01/

ENTRYPOINT ["/u01/scripts/entrypoint.sh"]
