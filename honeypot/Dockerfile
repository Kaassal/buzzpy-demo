FROM python:3.12-slim

WORKDIR /app

RUN apt-get update && apt-get install -y \
    git \
    curl \
    openssh-server \
    && rm -rf /var/lib/apt/lists/*

RUN git clone https://github.com/Kaassal/buzzpy.git . \
    && pip install -r requirements.txt \
    && ssh-keygen -t rsa -b 4096 -f server.key -N "" -q

COPY buzzpy-config/docker-entrypoint.sh /app/entrypoint.sh
COPY buzzpy-config/log_files /app/demo_logs
RUN chmod +x /app/entrypoint.sh

ENTRYPOINT ["/app/entrypoint.sh"]