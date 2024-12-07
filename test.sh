#!/bin/sh -e

printf "=== Uploading a file to the fetcher bucket"
curl --request PUT --upload-file ./README.md http://localhost:9090/files/README.md

printf "\n=== Sending a job to Tika\n"
curl  -d '{ "id":"test","fetcher":"s3f", "fetchKey": "README.md", "emitter":"fse","emitKey":"test"}' \
      -X POST --silent --fail http://localhost:9998/pipes || docker logs tika; exit 1
