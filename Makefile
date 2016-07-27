# Wedit Makefile for project altermime
#CC=cc
#CC=ccmalloc gcc
#CFLAGS=-Wall -g
#CFLAGS=-Wall -ggdb

# Optional builds
#	ALTERMIME_PRETEXT - Allows prefixing of the email body with a file, sort of the
#								opposite of a disclaimer.
ALTERMIME_OPTIONS=-DALTERMIME_PRETEXT
#ALTERMIME_OPTIONS=
CFLAGS=-Wall -Werror -g -I. -O2 -Wp,-D_FORTIFY_SOURCE=2 -fstack-protector --param=ssp-buffer-size=4 -fPIC $(ALTERMIME_OPTIONS)
LDFLAGS=-Wl,-z,relro -Wl,-z,now -pie
OBJS= strstack.o mime_alter.o ffget.o pldstr.o filename-filters.o logger.o MIME_headers.o libmime-decoders.o boundary-stack.o qpe.o
VERSION=\""alterMIME $(shell git describe --long --dirty) - https://github.com/ac000/altermime/tree/fixs ($(shell date +%B-%Y)). alterMIME by Paul L Daniels - http://www.pldaniels.com/altermime\n"\"


.c.o:
	${CC} ${CFLAGS} -c $*.c

all: altermime

altermime: altermime.c ${OBJS}
	${CC} ${CFLAGS} ${LDFLAGS} altermime.c ${OBJS} -o altermime -DALTERMIMEAPP_VERSION=${VERSION}


# Build Install
install: altermime
	strip altermime
	cp altermime /usr/local/bin
	chmod a+rx /usr/local/bin/altermime

uninstall:
	rm -f /usr/local/bin/altermime

clean:
	rm -f *.o altermime
