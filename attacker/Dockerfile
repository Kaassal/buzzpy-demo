FROM kalilinux/kali-rolling

RUN apt-get update && apt-get install -y \
    nmap \
    hydra \
    curl \
    openssh-client \
    && mkdir -p /usr/share/wordlists \
    && curl -L https://github.com/brannondorsey/naive-hashcat/releases/download/data/rockyou.txt \
        -o /usr/share/wordlists/rockyou.txt \
    && printf "user\nadmin\nsysadmin\n" > /usr/share/wordlists/users.txt \
    && rm -rf /var/lib/apt/lists/*

WORKDIR /root

RUN echo 'alias scan-ports="nmap -sV -T4 172.19.0.100"' >> .bashrc \
    && echo 'alias brute-ssh="hydra -L /usr/share/wordlists/users.txt -P /usr/share/wordlists/rockyou.txt ssh://172.19.0.100:2222 -t 4"' >> .bashrc

CMD ["sleep", "infinity"]
