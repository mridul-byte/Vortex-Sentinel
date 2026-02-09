#!/bin/bash
# Vortex-Sentinel: Self-Healing Logic
echo -e "\e[1;31m[!] Repairing Environment Integrity...\e[0m"

# Fix broken package manager states
dpkg --configure -a
pkg update

# Re-install core binaries and fix shebangs for Termux
pkg install --reinstall python clang termux-api -y
termux-fix-shebang vortex.py

# Re-compile C++ binary to ensure it matches architecture
clang++ core/engine.cpp -o core/engine

echo -e "\e[1;32m[+] Fix Applied. System Restored.\e[0m"
