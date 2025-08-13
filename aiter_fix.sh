#!/bin/bash

ORIGINAL_DIR=$(pwd)
pip uninstall aiter -y

mkdir -p /app/aiter_fixed/
cd /app/aiter_fixed/
git clone https://github.com/ROCm/aiter.git
cd aiter
git checkout akif/hybrid_kv_fix
python3 setup.py develop
cd "$ORIGINAL_DIR"