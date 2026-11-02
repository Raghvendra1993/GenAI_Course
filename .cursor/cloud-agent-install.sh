#!/usr/bin/env bash
set -euo pipefail

if ! python3 -m venv /tmp/.cursor-venv-probe >/dev/null 2>&1; then
  sudo DEBIAN_FRONTEND=noninteractive apt-get update -qq
  sudo DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends python3-venv python3-pip
fi
rm -rf /tmp/.cursor-venv-probe

if [ -f requirements.txt ]; then
  if [ ! -d .venv ]; then
    python3 -m venv .venv
  fi
  .venv/bin/pip install -U pip
  .venv/bin/pip install -r requirements.txt
fi

printf 'GenAI Course workspace ready (%s).\n' "$(python3 --version)"
if [ ! -f requirements.txt ]; then
  echo 'No requirements.txt yet; add course dependencies when content is available.'
fi
