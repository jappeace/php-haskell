#! /bin/sh

set -xe

php -nf "$1" > "$3"
