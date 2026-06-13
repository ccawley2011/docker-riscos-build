#!/bin/sh

_product=$1
if [ -z "$_product" ]; then
    echo "No product has been specified"
    exit 1
fi

git clone --recurse-submodules --remote-submodules https://gitlab.riscosopen.org/Products/$_product.git
./scripts/branches.sh $_product
