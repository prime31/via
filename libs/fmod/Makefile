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
	[ -d $(MODULE_FOLDER)/linux ] || mkdir $(MODULE_FOLDER)/linux
	rsync -rpEl '$(FMOD_FOLDER)/api/core/lib/x86_64/' $(MODULE_FOLDER)/linux/
	rsync -rpEl '$(FMOD_FOLDER)/api/studio/lib/x86_64/' $(MODULE_FOLDER)/linux/
	rsync -rpEl '$(FMOD_FOLDER)/api/core/lib/x86_64/' /usr/local/lib/linux/
	rsync -rpEl '$(FMOD_FOLDER)/api/studio/lib/x86_64/' /usr/local/libcd/linux/

copy_files_macos:
	[ -d $(MODULE_FOLDER)/macos ] || mkdir $(MODULE_FOLDER)/macos
	cp '$(FMOD_FOLDER)/api/core/lib/libfmod.dylib' $(MODULE_FOLDER)/macos/
	cp '$(FMOD_FOLDER)/api/core/lib/libfmodL.dylib' $(MODULE_FOLDER)/macos/
	cp '$(FMOD_FOLDER)/api/studio/lib/libfmodstudio.dylib' $(MODULE_FOLDER)/macos/
	cp '$(FMOD_FOLDER)/api/studio/lib/libfmodstudioL.dylib' $(MODULE_FOLDER)/macos/

clean:
	rm -rf '$(FMOD_FOLDER)'
