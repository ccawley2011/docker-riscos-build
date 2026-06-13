#!/bin/bash -e

[ "$CROSSTOOLS" != "" ] || { echo "CROSSTOOLS has not been defined"; exit 1; }
[ "$ROOL_BIN" != "" ] || { echo "ROOL_BIN has not been defined"; exit 1; }

export INSTDIR=$ROOL_BIN
mkdir -p $INSTDIR
export PATH=$PATH:$INSTDIR

# Build tools 32-bit for now, since not all of them are 64-bit safe
export CFLAGS=-m32
export CXXFLAGS=-m32
export LDFLAGS=-m32

# Fetch the cross-tools
git clone --remote-submodules --recurse-submodules https://gitlab.riscosopen.org/Products/CrossTools.git $CROSSTOOLS

# Add missing submodules for the tools
pushd $CROSSTOOLS
git submodule add https://gitlab.riscosopen.org/RiscOS/Sources/Apps/SquashApp.git RiscOS/Sources/Apps/SquashApp
git submodule add https://gitlab.riscosopen.org/RiscOS/Tools/Sources/squeeze.git RiscOS/Tools/Sources/squeeze
git submodule add https://gitlab.riscosopen.org/RiscOS/Tools/Sources/modsqz.git RiscOS/Tools/Sources/modsqz
git submodule add https://gitlab.riscosopen.org/RiscOS/Tools/Sources/toansi.git RiscOS/Tools/Sources/toansi
git submodule add https://gitlab.riscosopen.org/RiscOS/Tools/Sources/tokenise.git RiscOS/Tools/Sources/tokenise
git submodule add https://gitlab.riscosopen.org/RiscOS/Tools/Sources/topcc.git RiscOS/Tools/Sources/topcc
git submodule add https://gitlab.riscosopen.org/RiscOS/Tools/Sources/unmodsqz.git RiscOS/Tools/Sources/unmodsqz
git submodule add https://gitlab.riscosopen.org/RiscOS/Tools/Sources/toffb.git RiscOS/Tools/Sources/toffb
git submodule add https://gitlab.riscosopen.org/RiscOS/Utilities/Release/srcbuild.git RiscOS/Utilities/Release/srcbuild
popd

# Apply fixes from pending merge requests
./branches.sh $CROSSTOOLS

# Configure your environment for building tools using native GCC/etc
source $CROSSTOOLS/RiscOS/Env/ROOL/CrossTools.sh

# Export headers
make -C $CROSSTOOLS/RiscOS/Sources/Lib/RISC_OSLib export_hdrs
make -C $CROSSTOOLS/RiscOS/Sources/Lib/CLXLite export_hdrs
make -C $CROSSTOOLS/RiscOS/Sources/Programmer/Squash export_hdrs COMPONENT=SquashLib

# Export libraries
make -C $CROSSTOOLS/RiscOS/Sources/Lib/RISC_OSLib export_libs
make -C $CROSSTOOLS/RiscOS/Sources/Lib/CLXLite export_libs
make -C $CROSSTOOLS/RiscOS/Sources/Programmer/Squash export_libs COMPONENT=SquashLib

# Build host tools
make -C $CROSSTOOLS/RiscOS/Sources/Apps/SquashApp install INSTTYPE=tool
make -C $CROSSTOOLS/RiscOS/Tools/Sources/squeeze install TARGET=armsqueeze
make -C $CROSSTOOLS/RiscOS/Tools/Sources/modsqz install
make -C $CROSSTOOLS/RiscOS/Tools/Sources/toansi install
make -C $CROSSTOOLS/RiscOS/Tools/Sources/tokenise install
make -C $CROSSTOOLS/RiscOS/Tools/Sources/topcc install
make -C $CROSSTOOLS/RiscOS/Tools/Sources/unmodsqz install
make -C $CROSSTOOLS/RiscOS/Utilities/Release/srcbuild install
make -C $CROSSTOOLS/RiscOS/Tools/Sources/toffb install
