#!/usr/bin/env bash

#https://github.com/OpenAPITools/openapi-generator
openapi-generator generate -i ./chat.api-oas3.yaml -g go-gin-server -o ../../chat_api_go_server
