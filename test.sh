#!/bin/sh -e

printf "=== Uploading a file to the fetcher bucket"
curl --request PUT --upload-file ./README.md http://localhost:9090/files/README.md

printf "\n=== Sending a job to Tika\n"
curl  -d '{ "id":"test","fetcher":"s3f", "fetchKey": "README.md", "emitter":"fse"}' \
      -X POST http://localhost:9998/pipes

printf "\n=== Checking results after emitWithinMillis\n"
sleep 2

if [ ! -f ./output/README.md.json ]; then
    printf "File not found!\n"
    docker logs tika
    exit 1
fi

printf "\n=== Tika works!"