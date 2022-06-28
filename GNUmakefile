DESTDIR ?= install
MAKEFLAGS += --no-builtin-rules

WARNINGS = -Wall -Wextra -Wformat=2 -Wstrict-aliasing=3 -Wstrict-overflow=5 -Wstack-usage=12500 \
	-Wfloat-equal -Wcast-align -Wpointer-arith -Wchar-subscripts -Warray-bounds=2 \
	-Wno-unused-parameter

override CXXFLAGS ?= -Os $(WARNINGS) $(EXTRA_WARNINGS)
override CXXFLAGS += -std=c++17 -fvisibility=hidden
override CPPFLAGS += -D_DEFAULT_SOURCE
override LDFLAGS += -static-libgcc -static-libstdc++
override LDFLAGS += -Wl,--subsystem,windows -Wl,--exclude-all-symbols -Wl,--strip-all

src = elden_ring_item_randomiser
libs = elden_ring_param_randomiser.dll
all: $(libs)

%.dll:
	$(LINK.cpp) -shared $(filter %.c %.cpp,$^) $(LDLIBS) -o $@
	chmod 644 $@

$(libs): %: $(src)/dllmain.cpp $(src)/item_randomiser_main.cpp
$(libs): %: $(src)/RandomiserProperties/randomiser_properties.cpp
$(libs): %: $(src)/Randomiser/randomiser.cpp
$(libs): %: $(src)/Hooks/item_randomiser_hooks.cpp
$(libs): %: $(src)/INIReader/INIReader.cpp $(src)/INIReader/ini.cpp
$(libs): %: $(src)/MinHook/src/buffer.c $(src)/MinHook/src/hook.c $(src)/MinHook/src/trampoline.c
$(libs): %: $(src)/MinHook/src/hde/hde32.c $(src)/MinHook/src/hde/hde64.c

install:
	mkdir -p $(DESTDIR)/ItemRandomiser
	cp randomiserpreferences.ini $(DESTDIR)/ItemRandomiser/
	cp $(libs) $(DESTDIR)/

clean:
	$(RM) $(libs)

.DELETE_ON_ERROR:
.PHONY: all clean
