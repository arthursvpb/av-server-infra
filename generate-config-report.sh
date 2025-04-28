#!/bin/bash

OUTFILE="./config-report.txt"
echo "🔧 Config Report - $(date)" >"$OUTFILE"
echo "==============================" >>"$OUTFILE"

echo -e "\n=== 🖧 IP Info ===" >>"$OUTFILE"
ip addr show >>"$OUTFILE"
echo -e "\n--- Routing ---" >>"$OUTFILE"
ip route >>"$OUTFILE"

echo -e "\n=== ⚙️ Netplan Configuration ===" >>"$OUTFILE"
for f in /etc/netplan/*.yaml; do
  echo -e "\n--- $f ---" >>"$OUTFILE"
  sudo cat "$f" >>"$OUTFILE" 2>/dev/null
done

echo -e "\n=== 📡 DNS Info ===" >>"$OUTFILE"
ls -l /etc/resolv.conf >>"$OUTFILE"
cat /etc/resolv.conf 2>/dev/null >>"$OUTFILE"

echo -e "\n=== 🔥 Firewall (UFW) ===" >>"$OUTFILE"
sudo ufw status numbered >>"$OUTFILE"

echo -e "\n=== 📺 Plex Service ===" >>"$OUTFILE"
sudo systemctl status plexmediaserver >>"$OUTFILE"

echo -e "\n=== 🧠 Dnsmasq Service ===" >>"$OUTFILE"
sudo systemctl status dnsmasq >>"$OUTFILE"
echo -e "\n--- /etc/dnsmasq.d/upstream.conf ---" >>"$OUTFILE"
cat /etc/dnsmasq.d/upstream.conf 2>/dev/null >>"$OUTFILE"

echo -e "\n=== 🗂️ /etc/hosts ===" >>"$OUTFILE"
cat /etc/hosts >>"$OUTFILE"

echo -e "\n✅ Done! Output saved to $OUTFILE"
