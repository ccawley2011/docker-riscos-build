#!/bin/sh
DIR=$@

cross_compile_branch() {
	if test -d "$DIR/$1"; then
		(cd $DIR/$1 &&
		 git remote add $2 https://gitlab.riscosopen.org/$2.git &&
		 git fetch $2 &&
		 git checkout $2/$3)
	else
		echo "Skipping $1"
	fi
}

# Apply fixes from pending merge requests
cross_compile_branch RiscOS/Sources/Apps/SquashApp bavison/SquashApp CrossCompilationSupport
cross_compile_branch RiscOS/Sources/FileSys/ADFS/ADFSFiler bavison/ADFSFiler CrossCompilationSupport
cross_compile_branch RiscOS/Tools/Sources/Squish bavison/Squish CrossCompilationSupport
cross_compile_branch RiscOS/Sources/Kernel bavison/Kernel CrossCompilationSupport
cross_compile_branch RiscOS/Sources/Desktop/Free bavison/Free CrossCompilationSupport
cross_compile_branch RiscOS/Sources/Desktop/Filer bavison/Filer CrossCompilationSupport
cross_compile_branch RiscOS/Sources/FileSys/FileCore bavison/FileCore CrossCompilationSupport
cross_compile_branch RiscOS/Sources/Internat/Territory/TerritoryManager bavison/TerritoryManager CrossCompilationSupport
cross_compile_branch RiscOS/Sources/FileSys/RAMFS/RAMFS bavison/RAMFS CrossCompilationSupport
cross_compile_branch RiscOS/Sources/FileSys/SCSIFS/SCSIFS bavison/SCSIFS CrossCompilationSupport
cross_compile_branch RiscOS/Sources/FileSys/ADFS/ADFS bavison/ADFS CrossCompilationSupport
cross_compile_branch RiscOS/Sources/HWSupport/VFPSupport bavison/VFPSupport CrossCompilationSupport
cross_compile_branch RiscOS/Sources/Networking/Econet bavison/Econet CrossCompilationSupport
cross_compile_branch RiscOS/Sources/HWSupport/Sound/Sound0HAL bavison/Sound0HAL CrossCompilationSupport
cross_compile_branch RiscOS/Sources/HWSupport/Podule bavison/Podule CrossCompilationSupport
cross_compile_branch RiscOS/Sources/HWSupport/PCI bavison/PCI CrossCompilationSupport
cross_compile_branch RiscOS/Sources/Video/UserI/ScrSavers/AcornLogo ccawley/AcornLogo cross-compile
cross_compile_branch RiscOS/Sources/Video/UserI/ScrSavers/Circles ccawley/Circles cross-compile
cross_compile_branch RiscOS/Sources/Video/UserI/ScrSavers/Pogo ccawley/Pogo cross-compile
cross_compile_branch RiscOS/Sources/Video/UserI/ScrSavers/ScrBounce ccawley/ScrBounce cross-compile
cross_compile_branch RiscOS/Sources/Video/UserI/ScrSavers/Scrolling ccawley/Scrolling cross-compile
cross_compile_branch RiscOS/Sources/Video/UserI/ScrSavers/Slider ccawley/Slider cross-compile
cross_compile_branch RiscOS/Sources/Video/UserI/ScrSavers/Smear ccawley/Smear cross-compile
cross_compile_branch RiscOS/Sources/Video/UserI/ScrSavers/Swarm ccawley/Swarm cross-compile
cross_compile_branch RiscOS/Library ccawley/Library bin2h
cross_compile_branch RiscOS/BuildSys ccawley/BuildSys bin2h
cross_compile_branch RiscOS/Tools/Sources/squeeze ccawley/squeeze bin2h
