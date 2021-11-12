#!/bin/bash

set -Eeuxo pipefail
rm -rf working
mkdir working
cd working

# Checkout upstream

git clone --depth 1 --branch master https://github.com/docker-library/golang.git
cd golang

# Transform

sed -i -e "1 s/FROM.*/FROM ghcr.io\/golden-containers\/buildpack-deps\:bullseye-scm/; t" -e "1,// s//FROM ghcr.io\/golden-containers\/buildpack-deps\:bullseye-scm/" 1.17/bullseye/Dockerfile

# Build

docker build 1.17/bullseye/ --tag ghcr.io/golden-containers/golang:1.17-bullseye --label ${1:-DEBUG=TRUE}

# Push

docker push ghcr.io/golden-containers/golang -a
