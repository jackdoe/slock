# slock version
VERSION = 1.2

# Customize below to fit your system

# paths
PREFIX = /usr/local

X11INC = /usr/X11R6/include
X11LIB = /usr/X11R6/lib

# includes and libs
INCS = -I. -I/usr/include -I${X11INC} -I/usr/local/include


# On OpenBSD and Darwin remove -lcrypt from LIBS
LIBS = -L/usr/lib -L/usr/local/lib -lc -L${X11LIB} -lX11 -lXext -lpam -lcrypt

# flags
# On *BSD remove -DHAVE_SHADOW_H from CPPFLAGS and add -DHAVE_BSD_AUTH
CPPFLAGS = -DVERSION=\"${VERSION}\" -DHAVE_SHADOW_H -DCOLOR1=\"black\" -DCOLOR2=\"\#005577\"
CFLAGS = -std=c99 -pedantic -Wall -Os ${INCS} ${CPPFLAGS}
LDFLAGS = -s ${LIBS}


# compiler and linker
CC = cc

# Install mode. On BSD systems MODE=2755 and GROUP=auth
# On others MODE=4755 and GROUP=root
#MODE=2755
#GROUP=auth
