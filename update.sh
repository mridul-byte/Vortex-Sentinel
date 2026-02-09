#!/bin/bash
# Vortex-Sentinel: Automated Version Synchronizer
echo "[*] Checking Remote Repository for Updates..."

# Fetch and force-sync with the main branch
git fetch --all
git reset --hard origin/main

# Re-run installer for new configuration changes
bash install.sh

echo "[+] Vortex-Sentinel is now at the latest version."
