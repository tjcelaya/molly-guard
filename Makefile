prefix?=/usr/local
etcdir?=$(prefix)/etc
cfgdir?=$(etcdir)/molly-guard
libdir?=$(prefix)/lib
sbindir?=$(prefix)/sbin
REALPATH?=/sbin

all: molly-guard.8.gz shutdown

%.8: DB2MAN=/usr/share/sgml/docbook/stylesheet/xsl/nwalsh/manpages/docbook.xsl
%.8: XP=xsltproc -''-nonet
%.8: %.xml
	$(XP) $(DB2MAN) $<

%.gz: %
	gzip -9 < $< > $@

man: molly-guard.8
	man -l $<
.PHONY: man

clean:
	rm -f shutdown
	rm -f molly-guard.8 molly-guard.8.gz
.PHONY: clean

shutdown: shutdown.in
	sed -e 's,@cfgdir@,$(cfgdir),g;s,@REALPATH@,$(REALPATH),g' $< > $@

install: shutdown molly-guard.8.gz
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
