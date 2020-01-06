OPTS := -DPHYSFS_ARCHIVE_ZIP=ON
OPTS := -PHYSFS_ARCHIVE_7Z=OFF
OPTS := -DPHYSFS_ARCHIVE_ISO9660=OFF
OPTS += -DPHYSFS_ARCHIVE_VDF=OFF
OPTS += -DPHYSFS_ARCHIVE_SLB=OFF
OPTS += -DPHYSFS_ARCHIVE_QPAK=OFF
OPTS += -DPHYSFS_ARCHIVE_MVL=OFF
OPTS += -DPHYSFS_ARCHIVE_HOG=OFF
OPTS += -DPHYSFS_ARCHIVE_WAD=OFF
OPTS += -DPHYSFS_ARCHIVE_GRP=OFF

OPTS += -DPHYSFS_BUILD_SHARED=OFF
OPTS += -DPHYSFS_BUILD_TEST=OFF

CFLAGS := -I physfs_hg/src
CFLAGS += `sdl2-config --cflags`

MODULE_FOLDER := thirdparty
$(shell mkdir -p $(MODULE_FOLDER))

TARGET = fetch_and_build

##---------------------------------------------------------------------
## BUILD FLAGS PER PLATFORM
##---------------------------------------------------------------------
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	TARGET += copy_static_lib
else ifeq ($(UNAME_S), Darwin)
	TARGET += copy_static_lib
endif

TARGET += physfsrwops.o


all: $(TARGET) clean

fetch_and_build:
	[ -d physfs_hg ] || hg clone https://hg.icculus.org/icculus/physfs physfs_hg
	(cd physfs_hg ; mkdir build ; cd build ; cmake $(OPTS) .. ; make)
	cp physfs_hg/src/physfs.h $(MODULE_FOLDER)

copy_static_lib:
	cp physfs_hg/src/physfs.h $(MODULE_FOLDER)
	cp physfs_hg/build/libphysfs.a $(MODULE_FOLDER)

copy_dll:
	cp physfs_hg/src/physfs.h $(MODULE_FOLDER)
	cp physfs_hg/build/libphysfs.dll $(MODULE_FOLDER)

# physfsrwops.o: physfs_hg/extras/physfsrwops.c
# 	$(CC) $(CFLAGS) -c -o physfs_hg/build/$@ $<
# 	cp physfs_hg/extras/physfsrwops.h $(MODULE_FOLDER)
# 	cp physfs_hg/build/physfsrwops.o $(MODULE_FOLDER)

clean:
	rm -rf physfs_hg
