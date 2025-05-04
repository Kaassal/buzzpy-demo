#!/bin/bash
set -e

mkdir -p /app/log_files

if [ "$DEMO_MODE" = "1" ] && [ "$LOAD_SAMPLE_DATA" = "1" ]; then
    echo "=== CARGANDO LOGS DEMO ==="
    rm -rf /app/log_files/*
    cp -av /app/demo_logs/. /app/log_files/
fi

DEMO_FLAG=""
if [ "$DEMO_MODE" = "1" ]; then
    DEMO_FLAG="-d"
fi

python buzzpy.py -s -a 0.0.0.0 -p 2222 -u admin -P batman $DEMO_FLAG &
python buzzpy.py -w -a 0.0.0.0 -p 8080 -u admin -P batman $DEMO_FLAG &
python buzzpy.py -D -a 0.0.0.0 -p 8050 &

wait