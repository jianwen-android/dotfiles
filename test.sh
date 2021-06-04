#!/bin/bash

macos() {
    echo pog
}

if [ "$(uname -s)" = "Darwin" ]; then
    macos
else
    echo not pog
fi