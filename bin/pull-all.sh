#!/usr/bin/env bash
set -euo pipefail

BASE_DIR="$HOME" # change this to target


PORTS=(9800 9800) 
PORT_COUNT=${#PORTS[@]}
PORT_INDEX=0

echo "updating git repositories..."

# this checks if a directory is a repository and pulls the latest changes
for dir in "$BASE_DIR"/*/ ; do
    if [[ -d "$dir/.git" ]]; then
        echo "→ Entering $dir"
        ( cd "$dir" && git pull )
    fi
done

echo -e "building websites with assigned ports..."

for dir in "$BASE_DIR"/*/ ; do
    # checks if it's a node.js project, if you use Deno you might need to change this
    if [[ -f "$dir/package.json" ]]; then 
        CURRENT_PORT=${PORTS[$PORT_INDEX]}

        echo "building in $dir using PORT: $CURRENT_PORT"

        (
            cd "$dir"
            npm run build -- --port "$CURRENT_PORT"
        )

        PORT_INDEX=$(( (PORT_INDEX + 1) % PORT_COUNT ))
    fi
done

echo -e "restarting pm2..."
pm2 restart all
