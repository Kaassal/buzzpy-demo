#!/bin/bash

# Configurar modo de operación
MODE_ARGS=""
if [ "$DEMO_MODE" = "1" ]; then
    MODE_ARGS="-d"
    echo "=== MODO DEMO ACTIVADO ==="
    
    # Cargar logs de demostración
    if [ "$LOAD_SAMPLE_DATA" = "1" ]; then
        echo "=== CARGANDO LOGS DEMO ==="
        rm -rf /app/log_files/*
        cp -v /app/demo_logs/* /app/log_files/
    fi
fi

# Ejecutar servicios en background
python buzzpy.py -s -a 0.0.0.0 -p 2222 -u admin -P password $MODE_ARGS &
python buzzpy.py -w -a 0.0.0.0 -p 8080 -u admin -P password $MODE_ARGS &
python buzzpy.py -D -a 0.0.0.0 -p 8050 &

# Mantener contenedor activo
tail -f /dev/null