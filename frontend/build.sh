#!/usr/bin/env bash

set -e

if [[ $PWD != */frontend ]]; then
    echo "This script is meant to be run in the frontend directory"
    exit 1
fi

if [ $# -eq 0 ]; then
    echo "Building for dev"
    dev_mode=true
else
    echo "Building for prod"
    dev_mode=false
fi

rm -rf dist
mkdir dist
cp ./*.html dist/

if command -v wasm32-wasi-cabal &>/dev/null; then
    wasm32-wasi-cabal build ghc-wasm-reflex-examples
else
    cabal \
        --with-compiler=wasm32-wasi-ghc \
        --with-hc-pkg=wasm32-wasi-ghc-pkg \
        --with-hsc2hs=wasm32-wasi-hsc2hs \
        build ghc-wasm-reflex-examples
fi

hs_wasm_path=$(find .. -name "*.wasm")

"$(wasm32-wasi-ghc --print-libdir)"/post-link.mjs \
     --input "$hs_wasm_path" --output ghc_wasm_jsffi.js

if $dev_mode; then
    cp "$hs_wasm_path" dist/bin.wasm
else
    env -i GHCRTS=-H64m "$(type -P wizer)" --allow-wasi --wasm-bulk-memory true --inherit-env true --init-func _initialize -o dist/bin.wasm "$hs_wasm_path"
    wasm-opt ${1+"$@"} dist/bin.wasm -o dist/bin.wasm
    wasm-tools strip -o dist/bin.wasm dist/bin.wasm
fi

cp ./*.js dist
