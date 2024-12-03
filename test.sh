#!/bin/sh -e

printf "=== Uploading a file to the fetcher bucket"
curl --request PUT --upload-file ./README.md http://localhost:9090/files/README.md

printf "\n=== Sending a job to Tika\n"
curl  -d '{ "id":"test","fetcher":"s3f", "fetchKey": "README.md", "emitter":"s3e"}' \
      -X POST http://localhost:9998/pipes

printf "\n=== Checking results\n"
curl  --fail  "http://localhost:9090/tika-results/README.md.json" || { printf "Tika doesn't work"; exit 1; }

printf "\n=== Tika works!"