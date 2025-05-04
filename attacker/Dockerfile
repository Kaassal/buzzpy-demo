FROM kalilinux/kali-rolling

RUN apt-get update && apt-get install -y \
    nmap \
    hydra \
    curl \
    && mkdir -p /usr/share/wordlists \
    && curl -L https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt -o /usr/share/wordlists/rockyou.txt \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

# Aliases para ataques
RUN echo 'alias scan-ports="nmap -sV -T4 172.19.0.100"' >> .bashrc && \
    echo 'alias brute-ssh="hydra -l admin -P /usr/share/wordlists/rockyou.txt ssh://172.19.0.100:2222 -t 4"' >> .bashrc

CMD ["sleep", "infinity"]