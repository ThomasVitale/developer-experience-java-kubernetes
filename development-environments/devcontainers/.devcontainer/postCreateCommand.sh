#!/bin/sh

nix profile install \
    --experimental-features "nix-command flakes" \
    --accept-flake-config \
    'github:flox/flox'
