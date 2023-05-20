#!/bin/bash
set -Eeo pipefail
export PATH=$HOME/.cargo/bin:$PATH
source /usr/share/nvm/init-nvm.sh

cd /home/build/decent

if [ $# -eq 0 ]; then
    make -j $(nproc)
    exit 0
fi

deno test -A --parallel