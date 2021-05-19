include config.mk

SRC = Drw.c IQ-MENU.c Stest.c Util.c
OBJ = $(SRC:.c=.o)

all: options IQ-MENU Stest

options:
	@echo IQ-MENU build options:
	@echo "CFLAGS   = $(CFLAGS)"
	@echo "LDFLAGS  = $(LDFLAGS)"
	@echo "CC       = $(CC)"

.c.o:
	$(CC) -c $(CFLAGS) $<

Config.h:
	cp Config.def.h $@

$(OBJ): Arg.h Config.h config.mk Drw.h

IQ-MENU: IQ-MENU.o Drw.o Util.o
	$(CC) -o $@ IQ-MENU.o Drw.o Util.o $(LDFLAGS)

Stest: Stest.o
	$(CC) -o $@ Stest.o $(LDFLAGS)

clean:
	rm -f IQ-MENU Stest $(OBJ) IQ-MENU-$(VERSION).tar.gz *.rej *.orig

dist: clean
	mkdir -p IQ-MENU-$(VERSION)
	cp Makefile Arg.h Config.def.h config.mk IQ-MENU.1\
		Drw.h Util.h IQ-MENU-Path IQ-MENU-Run Stest.1 $(SRC)\
		IQ-MENU-$(VERSION)
	tar -cf IQ-MENU-$(VERSION).tar IQ-MENU-$(VERSION)
	gzip IQ-MENU-$(VERSION).tar
	rm -rf IQ-MENU-$(VERSION)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f IQ-MENU IQ-MENU-Path IQ-MENU-Run Stest $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/IQ-MENU
	chmod 755 $(DESTDIR)$(PREFIX)/bin/IQ-MENU-Path
	chmod 755 $(DESTDIR)$(PREFIX)/bin/IQ-MENU-Run
	chmod 755 $(DESTDIR)$(PREFIX)/bin/Stest
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < IQ-MENU.1 > $(DESTDIR)$(MANPREFIX)/man1/IQ-MENU.1
	sed "s/VERSION/$(VERSION)/g" < Stest.1 > $(DESTDIR)$(MANPREFIX)/man1/Stest.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/IQ-MENU.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/Stest.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/IQ-MENU\
		$(DESTDIR)$(PREFIX)/bin/IQ-MENU-Path\
		$(DESTDIR)$(PREFIX)/bin/IQ-MENU-Run\
		$(DESTDIR)$(PREFIX)/bin/Stest\
		$(DESTDIR)$(MANPREFIX)/man1/IQ-MENU.1\
		$(DESTDIR)$(MANPREFIX)/man1/Stest.1

.PHONY: all options clean dist install uninstall
