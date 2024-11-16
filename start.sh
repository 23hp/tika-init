#!/bin/sh -e

#mkdir $JAR_PATH
#mkdir $CONFIG_PATH
if [ ! -d "$JAR_PATH" ]; then
  echo "$JAR_PATH is not mount."
  exit 1
fi
if [ ! -d "$CONFIG_PATH" ]; then
  echo "$CONFIG_PATH is not mount."
  exit 1
fi

echo "=== Copying config.xml and fork-log.xml to $CONFIG_PATH"
cp config.xml fork-log.xml $CONFIG_PATH
sed -i "s|{REGION}|$REGION|g; s|{BUCKET}|$BUCKET|g; s|{ACCESS_KEY}|$ACCESS_KEY|g; s|{SECRET_KEY}|$SECRET_KEY|g; s|{S3_ENDPOINT}|$S3_ENDPOINT|g;" ${CONFIG_PATH}/config.xml
echo "=== Files under $CONFIG_PATH"
ls $CONFIG_PATH

for JAR_NAME in tika-emitter-s3 tika-fetcher-s3 tika-fetcher-s3
do
    FILENAME=${JAR_NAME}-${TIKA_VERSION}.jar
    FILEPATH=${JAR_PATH}${FILENAME}
    if [ ! -f "$FILEPATH" ]; then
        echo "=== Downloading ${FILEPATH}"
        wget -t 10  https://repo1.maven.org/maven2/org/apache/tika/${JAR_NAME}/${TIKA_VERSION}/${FILENAME} -O ${FILEPATH}
    fi
done

echo "=== Files under $JAR_PATH"
ls $JAR_PATH
