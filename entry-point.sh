#!/bin/bash

# start supervisord for live reload.
/usr/bin/supervisord -c /etc/supervisord.conf

# start application main.
go run src/main.go