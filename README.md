# 🖥️ AV Server Infra

**Personal Infrastructure Repository** — This repository contains all infrastructure, automation scripts, and Docker-based services used to manage my personal Ubuntu Server.  
It includes backup/sync tools, media management, remote access enhancements, and lightweight containerized applications to streamline home server operations.

## 📂 Project Structure

```bash
.
├── config-report.txt                 # Generated server configuration report
├── generate-config-report.sh          # Script to generate server network/firewall status
├── portainer/
│   └── docker-compose.yml             # Portainer deployment for Docker web management
├── qbittorrent/
│   └── docker-compose.yml             # qBittorrent deployment for lightweight torrent management
├── rclone-plex-simple-sync.sh         # Custom rclone script to sync Plex media (OneDrive ↔ Local)
├── transcribe.sh                      # Whisper transcription script (video lectures, courses)
├── transcribe_with_faster_whisper.py  # Advanced Python transcription using FasterWhisper
```

## 🚀 Features

- Infrastructure as Code (IaC) with **Docker Compose**
- **Portainer** UI for Docker management over the web
- **qBittorrent** with web UI access via LAN
- **Plex media** sync automation using **rclone**
- **Transcription** automation using **Whisper** and **Faster-Whisper**
- **Custom server scripts** for reports, sync, and backups
- Lightweight, efficient setups — ideal for **home lab** or **on-premises servers**
