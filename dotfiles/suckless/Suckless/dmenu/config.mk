# dmenu version
VERSION = 5.2

# paths
PREFIX = /usr/local
MANPREFIX = $(PREFIX)/share/man

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# Xinerama, comment if you don't want it
# XINERAMALIBS  = -lXinerama
# XINERAMAFLAGS = -DXINERAMA

# freetype
FREETYPELIBS = -lfontconfig -lXft
FREETYPEINC = /usr/include/freetype2
# OpenBSD (uncomment)
# FREETYPEINC = $(X11INC)/freetype2

# includes and libs
INCS = -I$(X11INC) -I$(FREETYPEINC)
LIBS = -L$(X11LIB) -lX11 $(XINERAMALIBS) $(FREETYPELIBS)

# flags
CPPFLAGS = -fno-unwind-tables -fno-asynchronous-unwind-tables -ffunction-sections -fdata-sections -D_DEFAULT_SOURCE -D_BSD_SOURCE -D_XOPEN_SOURCE=700 -D_POSIX_C_SOURCE=200809L -DVERSION=\"$(VERSION)\" $(XINERAMAFLAGS)
CFLAGS   = -Werror -Wshadow -Wall -Wextra -Wpedantic -pedantic -ffast-math -mfancy-math-387 -fno-ident -fmerge-all-constants -fno-unroll-loops -fno-math-errno -std=c99 -pedantic -Wall -Ofast -ffunction-sections -fdata-sections $(INCS) $(CPPFLAGS)
LDFLAGS  = -Wl,--build-id=none -Wl,--hash-style=gnu,-Ofast,-flto -s $(LIBS)

# compiler and linker
CC = clang

# Stripper
STRIP = llvm-strip
STRIPFLAGS = --strip-all --remove-section=.eh_frame --remove-section=.eh_frame_ptr --remove-section=.note.gnu.gold-version --remove-section=.note.gnu.build-id --remove-section=.note.ABI-tag --remove-section=.note --remove-section=.gnu.version --remove-section=.comment --strip-debug --strip-unneeded

