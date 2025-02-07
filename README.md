# `ghc-wasm-reflex-examples`

[![Chat on Matrix](https://matrix.to/img/matrix-badge.svg)](https://matrix.to/#/#haskell-wasm:matrix.org)

The GHC wasm backend supports the
[JSFFI](https://ghc.gitlab.haskell.org/ghc/doc/users_guide/wasm.html#javascript-ffi-in-the-wasm-backend)
feature, allowing Haskell wasm apps to interop with JavaScript
seamlessly in the browser. This repo contains an example to
demonstrate this ability based on the
[`reflex`](https://reflex-frp.org/) frontend framework as well as an
experimental [`jsaddle-wasm`](https://github.com/amesgen/jsaddle-wasm)
library under the hood.

See also:
[`ghc-wasm-miso-examples`](https://github.com/tweag/ghc-wasm-miso-examples)

## Live demo

- [reflex-todomvc](https://tweag.github.io/ghc-wasm-reflex-examples/reflex-todomvc.html)

## Building

### With nix

Within the `nix develop` shell:

```sh
cd frontend
wasm32-wasi-cabal update
./build.sh
```

If you pass additional arguments to `build.sh`, they will be
redirected to `wasm-opt`, otherwise a dev build without `wasm-opt`
will be performed.

The artifacts will be available in `frontend/dist`.

### Without nix

You can set up the toolchain by either:

- Using
  [`ghc-wasm-meta`](https://gitlab.haskell.org/haskell-wasm/ghc-wasm-meta#getting-started-without-nix)
  directly to set up ghc 9.10
- Using [`ghcup`](https://www.haskell.org/ghcup/guide/#cross-support)
  to set up ghc 9.10 (9.10.1.20241021 or later, with TemplateHaskell
  support) and cabal >=3.14.

Then:

```sh
source ~/.ghc-wasm/env
cd frontend
./build.sh
```

## Acknowledgements

The examples are vendored and modified from the following projects:

- reflex-todomvc: based on https://github.com/reflex-frp/reflex-todomvc
