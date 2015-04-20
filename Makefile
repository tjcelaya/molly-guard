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
	mkdir -m755 --parent $(DEST)$(libdir)/molly-guard
	install -m755 -oroot -oroot shutdown $(DEST)$(libdir)/molly-guard/molly-guard

	mkdir -m755 --parent $(DEST)$(sbindir)
	ln -s $(libdir)/molly-guard/molly-guard $(DEST)$(sbindir)/poweroff
	ln -s $(libdir)/molly-guard/molly-guard $(DEST)$(sbindir)/halt
	ln -s $(libdir)/molly-guard/molly-guard $(DEST)$(sbindir)/reboot
	ln -s $(libdir)/molly-guard/molly-guard $(DEST)$(sbindir)/shutdown

	mkdir -m755 --parent $(DEST)$(cfgdir)
	install -m644 -oroot -oroot rc $(DEST)$(cfgdir)
	cp -r run.d $(DEST)$(cfgdir) \
	  && chown root.root $(DEST)$(cfgdir)/run.d && chmod 755 $(DEST)$(cfgdir)/run.d

	mkdir -m755 --parent $(DEST)$(cfgdir)/messages.d

	mkdir -m755 --parent $(DEST)$(prefix)/share/man/man8
	install -m644 -oroot -groot molly-guard.8.gz $(DEST)$(prefix)/share/man/man8
.PHONY: install

uninstall:
	rm $(DEST)$(sbindir)/poweroff
	rm $(DEST)$(sbindir)/halt
	rm $(DEST)$(sbindir)/reboot
	rm $(DEST)$(sbindir)/shutdown
	rm $(DEST)$(prefix)/share/man/man8/molly-guard.8.gz
.PHONY: uninstall
