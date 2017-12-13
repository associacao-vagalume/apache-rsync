#!/bin/bash

set -e

service ssh start
httpd-foreground
