include config.mk

SRC = Drw.c IQMenu.c Stest.c Util.c
OBJ = $(SRC:.c=.o)

all: options IQMenu Stest

options:
	@echo IQMenu build options:
	@echo "CFLAGS   = $(CFLAGS)"
	@echo "LDFLAGS  = $(LDFLAGS)"
	@echo "CC       = $(CC)"

.c.o:
	$(CC) -c $(CFLAGS) $<

Config.h:
	cp Config.def.h $@

$(OBJ): Arg.h Config.h config.mk Drw.h

IQMenu: IQMenu.o Drw.o Util.o
	$(CC) -o $@ IQMenu.o Drw.o Util.o $(LDFLAGS)

Stest: Stest.o
	$(CC) -o $@ Stest.o $(LDFLAGS)

clean:
	rm -f IQMenu Stest $(OBJ) IQMenu-$(VERSION).tar.gz *.rej *.orig

dist: clean
	mkdir -p IQMenu-$(VERSION)
	cp Makefile Arg.h Config.def.h config.mk IQMenu.1\
		Drw.h Util.h IQMenu_Path IQMenu_Run Stest.1 $(SRC)\
		IQMenu-$(VERSION)
	tar -cf IQMenu-$(VERSION).tar IQMenu-$(VERSION)
	gzip IQMenu-$(VERSION).tar
	rm -rf IQMenu-$(VERSION)

install: all
	mkdir -p $(DESTDIR)$(PREFIX)/bin
	cp -f IQMenu IQMenu_Path IQMenu_Run Stest $(DESTDIR)$(PREFIX)/bin
	chmod 755 $(DESTDIR)$(PREFIX)/bin/IQMenu
	chmod 755 $(DESTDIR)$(PREFIX)/bin/IQMenu_Path
	chmod 755 $(DESTDIR)$(PREFIX)/bin/IQMenu_Run
	chmod 755 $(DESTDIR)$(PREFIX)/bin/Stest
	mkdir -p $(DESTDIR)$(MANPREFIX)/man1
	sed "s/VERSION/$(VERSION)/g" < IQMenu.1 > $(DESTDIR)$(MANPREFIX)/man1/IQMenu.1
	sed "s/VERSION/$(VERSION)/g" < Stest.1 > $(DESTDIR)$(MANPREFIX)/man1/Stest.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/IQMenu.1
	chmod 644 $(DESTDIR)$(MANPREFIX)/man1/Stest.1

uninstall:
	rm -f $(DESTDIR)$(PREFIX)/bin/IQMenu\
		$(DESTDIR)$(PREFIX)/bin/IQMenu_Path\
		$(DESTDIR)$(PREFIX)/bin/IQMenu_Run\
		$(DESTDIR)$(PREFIX)/bin/Stest\
		$(DESTDIR)$(MANPREFIX)/man1/IQMenu.1\
		$(DESTDIR)$(MANPREFIX)/man1/Stest.1

.PHONY: all options clean dist install uninstall
