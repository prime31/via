MODULE_FOLDER := thirdparty
$(shell mkdir -p $(MODULE_FOLDER))

TARGET := remove_unused_folders
TARGET += copy_files

##---------------------------------------------------------------------
## BUILD FLAGS PER PLATFORM
##---------------------------------------------------------------------
UNAME_S := $(shell uname -s)

ifeq ($(UNAME_S), Linux)
	FMOD_FOLDER := fmodstudioapi
	TARGET += copy_files_linux
else ifeq ($(UNAME_S), Darwin)
	FMOD_FOLDER := FMOD Programmers API
	TARGET += copy_files_macos
endif

TARGET += clean


all: $(TARGET)

remove_unused_folders:
	rm -rf '$(FMOD_FOLDER)/api/core/examples'
	rm -rf '$(FMOD_FOLDER)/api/studio/examples'
	rm -rf '$(FMOD_FOLDER)/doc'
	rm -rf '$(FMOD_FOLDER)/plugins'

copy_files:
	[ -d $(MODULE_FOLDER)/studio ] || mkdir $(MODULE_FOLDER)/studio
	rsync -rpE --include="*/" --include="*.h" --exclude="*" '$(FMOD_FOLDER)/api/core/inc/' $(MODULE_FOLDER)/core
	rsync -rpE --include="*/" --include="*.h" --exclude="*" '$(FMOD_FOLDER)/api/studio/inc/' $(MODULE_FOLDER)/studio

copy_files_linux:
	rsync -rpEl '$(FMOD_FOLDER)/api/core/lib/x86_64/' $(MODULE_FOLDER)
	rsync -rpEl '$(FMOD_FOLDER)/api/studio/lib/x86_64/' $(MODULE_FOLDER)
	rsync -rpEl '$(FMOD_FOLDER)/api/core/lib/x86_64/' /usr/local/lib
	rsync -rpEl '$(FMOD_FOLDER)/api/studio/lib/x86_64/' /usr/local/libcd

copy_files_macos:
	cp '$(FMOD_FOLDER)/api/core/lib/libfmod.dylib' $(MODULE_FOLDER)
	cp '$(FMOD_FOLDER)/api/core/lib/libfmodL.dylib' $(MODULE_FOLDER)

clean:
	rm -rf '$(FMOD_FOLDER)'
