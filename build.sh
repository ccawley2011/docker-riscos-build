#!/bin/sh

# GCCSDK doesn't build for AArch64 yet, so always build for x86 instead.
docker build . -t docker-riscos:latest --platform=linux/amd64
