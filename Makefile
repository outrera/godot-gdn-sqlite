
BASE = scons n=GDNSQLite -j4
LINUX = $(BASE) p=linux
WINDOWS = $(BASE) p=windows
OSX = $(BASE) p=osx


all:
	make linux
	make windows


linux:
	make linux32
	make linux64

linux32: SConstruct
	$(LINUX) a=32

linux64: SConstruct
	$(LINUX) a=64


windows:
	make windows32
	make windows64

windows32: SConstruct
	$(WINDOWS) a=32

windows64: SConstruct
	$(WINDOWS) a=64


osx:
	make osx32
	make osx64

osx32: SConstruct
	$(OSX) a=32

osx64: SConstruct
	$(OSX) a=64
