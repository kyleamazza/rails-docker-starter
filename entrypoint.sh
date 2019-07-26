#!/bin/bash

set -e

# Remove possible pre-existing server.pid for Rails
rm -f /myapp/tmp/pids/server.pid

# Execute whatever the default passed-in command is
exec "$@"

