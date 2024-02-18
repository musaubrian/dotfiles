#!/usr/bin/env bash

# remove existing go then unzip
USAGE="goset path/to/zip"

rm -rf /usr/local/go && sudo tar -C /usr/local -xvf $1

