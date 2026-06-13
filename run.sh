#!/bin/sh

_path=$1
if [ -z "$_path" ]; then
	echo "No product directory has been specified"
	exit 1
fi

_realpath=`realpath $_path`
_product=`basename $_path`
_component=$_product

docker run --rm \
	-v $_realpath:/usr/src/$_product \
	-w /usr/src/$_product/RiscOS \
	-e COMPONENT=$_component \
	-it docker-riscos:latest \
	/bin/bash --init-file /usr/src/$_product/RiscOS/Env/ROOL/$_component.sh
