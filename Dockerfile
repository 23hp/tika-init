FROM alpine/curl:8.9.1
LABEL org.opencontainers.image.source="https://github.com/23hp/tika-init"
LABEL org.opencontainers.image.description="Initialize your docker tika server."
LABEL org.opencontainers.image.licenses="Apache-2.0"

COPY fork-log.xml config.xml start.sh /
RUN chmod +x /start.sh
ENV TIKA_VERSION="3.0.0" \
    S3_ENDPOINT="http://s3:9090" \
    BUCKET4FETCHER="files" \
    BUCKET4EMITTER="tika-results" \
    REGION="any" \
    ACCESS_KEY="any" \
    SECRET_KEY="any"
ENTRYPOINT ["/start.sh"]