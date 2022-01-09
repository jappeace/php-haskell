#! /usr/bin/env bash

set -xe

php -nf "$1" > "$3"
