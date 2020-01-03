#!/usr/bin/env bash

#https://github.com/OpenAPITools/openapi-generator
openapi-generator generate -i ./chat.api-oas3.yaml -g dart -o ../../chat_api_dart_client
