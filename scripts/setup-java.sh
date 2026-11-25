#!/usr/bin/env bash
set -euo pipefail

# Install Java 21 (Temurin) if it's missing
if ! command -v java >/dev/null 2>&1; then
  SUDO=""
  if command -v sudo >/dev/null 2>&1; then SUDO=sudo; fi
  case "$(uname -m)" in
    aarch64|arm64) ARCH=aarch64 ;;
    *) ARCH=x64 ;;
  esac
  $SUDO mkdir -p /opt/jdk21
  curl -fsSL "https://api.adoptium.net/v3/binary/latest/21/ga/linux/${ARCH}/jdk/hotspot/normal/eclipse" \
    | $SUDO tar -xz -C /opt/jdk21 --strip-components=1
  $SUDO ln -sf /opt/jdk21/bin/* /usr/local/bin/
fi

java -version
