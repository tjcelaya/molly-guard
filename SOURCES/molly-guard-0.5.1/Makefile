prefix?=/usr/local
etcdir?=$(prefix)/etc
cfgdir?=$(etcdir)/molly-guard
libdir?=$(prefix)/lib
sbindir?=$(prefix)/sbin
REALPATH?=/sbin

all: shutdown

clean:
	rm -f shutdown
.PHONY: clean

shutdown: shutdown.in
	sed -e 's,@cfgdir@,$(cfgdir),g;s,@REALPATH@,$(REALPATH),g' $< > $@

install: shutdown
	mkdir -m755 --parent $(DESTDIR)$(libdir)/molly-guard
	install -m755 shutdown $(DESTDIR)$(libdir)/molly-guard/molly-guard

	mkdir -m755 --parent $(DESTDIR)$(cfgdir)
	install -m644 rc $(DESTDIR)$(cfgdir)
	cp -r run.d $(DESTDIR)$(cfgdir)

	mkdir -m755 --parent $(DESTDIR)$(cfgdir)/messages.d

	mkdir -m755 --parent $(DESTDIR)$(prefix)/share/man/man8
	install -m644 molly-guard.8.gz $(DESTDIR)$(prefix)/share/man/man8
.PHONY: install

uninstall:
	rm $(DEST)$(sbindir)/poweroff
	rm $(DEST)$(sbindir)/halt
	rm $(DEST)$(sbindir)/reboot
	rm $(DEST)$(sbindir)/shutdown
	rm $(DEST)$(prefix)/share/man/man8/molly-guard.8.gz
.PHONY: uninstall
