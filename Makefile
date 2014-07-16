# slock - simple screen locker
# See LICENSE file for copyright and license details.

include config.mk

SRC = slock.c
OBJ = ${SRC:.c=.o}
all: options slock

options:
	@echo slock build options:
	@echo "CFLAGS   = ${CFLAGS}"
	@echo "LDFLAGS  = ${LDFLAGS}"
	@echo "CC       = ${CC}"

.c.o:
	@echo CC $<
	@${CC} -c ${CFLAGS} $<

${OBJ}: config.mk

slock: ${OBJ}
	@echo CC -o $@
	@${CC} -o $@ ${OBJ} ${LDFLAGS}

clean:
	@echo cleaning
	@rm -f slock ${OBJ} slock-${VERSION}.tar.gz

dist: clean
	@echo creating dist tarball
	@mkdir -p slock-${VERSION}
	@cp -R LICENSE Makefile README config.mk ${SRC} slock-${VERSION}
	@tar -cf slock-${VERSION}.tar slock-${VERSION}
	@gzip slock-${VERSION}.tar
	@rm -rf slock-${VERSION}

install: all
	@echo installing executable file to ${DESTDIR}${PREFIX}/bin and slock.pam into ${DESTDIR}${PREFIX}/etc
	@echo dont forget to edit ${DESTDIR}${PREFIX}/etc/pam.d/slock
	@mkdir -p ${DESTDIR}${PREFIX}/bin
	@mkdir -p ${DESTDIR}${PREFIX}/etc/pam.d
	@cp -f slock ${DESTDIR}${PREFIX}/bin
	@cp -f slock.pam ${DESTDIR}${PREFIX}/etc/pam.d/slock

	@chmod 755 ${DESTDIR}${PREFIX}/bin/slock
	@chmod u+s ${DESTDIR}${PREFIX}/bin/slock

uninstall:
	@echo removing executable file from ${DESTDIR}${PREFIX}/bin
	@rm -f ${DESTDIR}${PREFIX}/bin/slock
	@rm -f ${DESTDIR}${PREFIX}/etc/pam.d/slock
.PHONY: all options clean dist install uninstall
