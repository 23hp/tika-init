FROM busybox
LABEL website="https://github.com/23hp/tika-init" \
 description="Initialize your docker tika server."

ADD fork-log.xml config.xml start.sh /
RUN chmod +x /start.sh
ENV TIKA_VERSION="3.0.0" \
    CONFIG_PATH="/config/" \
    JAR_PATH="/tika-extras/" \
    S3_ENDPOINT="http://s3:9090" \
    BUCKET="development" \
    REGION="any" \
    ACCESS_KEY="any" \
    SECRET_KEY="any"
ENTRYPOINT /start.sh
