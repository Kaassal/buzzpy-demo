
# Buzzpy Demo Environment

A self-contained environment to showcase **Buzzpy** honeypot with real-time monitoring and a built-in attacker/pentester container.

> **Warning:** This is for demonstration purposes only. Do not deploy in production or expose to the public internet.

---

## Features

### Buzzpy Services
- **SSH Honeypot** — Port `2222`
- **Web Honeypot** — Port `8080`
- **Dashboard (Flask UI)** — Port `8050`
- **Demo Logs Autoload** — If `DEMO_MODE=1` and `LOAD_SAMPLE_DATA=1`

### Pentester Toolkit
- Based on `kali-rolling`
- Includes: `nmap`, `hydra`, `curl`, `openssh-client`
- Comes with:
  - `rockyou.txt` wordlist
  - `users.txt` with: `user`, `admin`, `sysadmin`
- Built-in aliases:

```bash
  scan-ports     # Quick Nmap scan of honeypot
  brute-ssh      # SSH brute force with Hydra
```

### Automation

- Fully managed with `Makefile`
    
- Single command to launch everything
    
- Separate modes: `production` and `demo`
    
- Isolated Docker network with fixed IPs
    

---

##  Quick Start

### Requirements

- Docker `20.10+`
    
- Docker Compose `1.29+`
    
- GNU Make
    
- 4GB+ RAM recommended


```bash
# Clone the repo
git clone https://github.com/yourusername/Buzzpy-Demo
cd Buzzpy-Demo

# Build images and start in demo mode
make build
make demo
```

### Access URLs

|Service|URL/Command|
|---|---|
|Dashboard|[http://localhost:8050](http://localhost:8050)|
|Web Honeypot|[http://localhost:8080](http://localhost:8080)|
|SSH Honeypot|`ssh admin@localhost -p 2222`|
|Pentester Shell|`make attack`|

---

## File Layout

```text
Buzzpy-Demo/
├── attacker/
│   └── Dockerfile             # Kali-based attacker
├── honeypot/
│   ├── Dockerfile             # Buzzpy honeypot
│   └── buzzpy-config/
│       ├── docker-entrypoint.sh
│       └── log_files/         # Demo logs (autoloaded in DEMO_MODE)
├── docker-compose.yml
├── Makefile
└── .env                       # Optional environment overrides
```

---

## Configuration

### Environment Variables

|Variable|Default|Purpose|
|---|---|---|
|`DEMO_MODE`|0|Enables demo hints/log preload|
|`LOAD_SAMPLE_DATA`|0|Load logs from `log_files` dir|

#### Example `.env`

```dotenv
DEMO_MODE=1
LOAD_SAMPLE_DATA=1
```

---
## Makefile Commands


```bash
make build         # Build all images
make run           # Run in production mode
make demo          # Run with sample logs and DEMO_MODE
make attack        # Enter attacker container shell
make clean         # Stop containers and remove volumes/networks
```

---

## Persistent Data

- All logs stored in volume `honeypot_logs`
    
- Demo logs copied into container on first run (demo mode)
    
- To reset everything:
    
```bash
make clean && make build
```


---

## Security Notes

1. Do **not** expose ports to the public internet
    
2. Demo containers run as root
	
3. Pentester container has full internal access
	
4. **Do not use this in production!**


---

## FAQ

**Q: How to change credentials?**  
Edit `docker-entrypoint.sh`:

SSH Example, check Buzzpy docs for more detailed documentation

```bash
python buzzpy.py -s -a 0.0.0.0 -p 2222 -u newuser -P newpass
```

**Q: Where are logs stored?**  
Inside container at `/app/log_files` (persisted via volume)

**Q: Can I add more pentesters?**  
Yes — duplicate and modify in `docker-compose.yml`:

```yaml
attacker2:
  build: ./attacker
  networks:
    honeypot_net:
      ipv4_address: 172.19.0.102
  depends_on:
    - honeypot
```

---

##  License

This project is under the MIT License.

Included components:

- [Buzzpy](https://github.com/Kaassal/buzzpy) — MIT

Always respect upstream licenses and use ethically.
