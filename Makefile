BUILD=build/html
BSTY=$(BUILD)/styles
ND_DOCSDIR=../doc/naturaldocs
BUILD_REFS=build/html/docs/references

all: rest2web $(BSTY)/default.css $(BSTY)/favicon.ico \
     $(BSTY)/augeas.css $(BSTY)/generic.css \
     $(BSTY)/default-debug.css $(BSTY)/debug.css \
     $(BSTY)/et_logo.png $(BSTY)/augeas-logo.png \
     $(BSTY)/footer_corner.png $(BSTY)/footer_pattern.png \
     $(BUILD)/docs/augeas.odp $(BUILD)/docs/augeas.pdf \
     $(BUILD)/docs/augeas-ols-2008.odp $(BUILD)/docs/augeas-ols-2008.pdf \
     naturaldocs

naturaldocs:
	(if test -d $(ND_DOCSDIR); then \
	   $(MAKE) -C $(ND_DOCSDIR); \
          fi; \
	  rm -rf $(BUILD_REFS); \
          mkdir -p $(BUILD_REFS); \
	  cp -pr $(ND_DOCSDIR)/output/* $(BUILD_REFS))

rest2web:
	PYTHONPATH=$$PWD python /homes/lutter/packages/rest2web-0.5.1/r2w.py

$(BUILD)/styles/%: pages/styles/%
	mkdir -p $(BUILD)/styles
	cp -a $< $@

$(BUILD)/docs/%.odp: pages/docs/%.odp
	cp -p $< $@

$(BUILD)/docs/%.pdf: pages/docs/%.pdf
	cp -p $< $@

sync:
	rsync -rav $(RSYNC_OPTS) $(BUILD)/ et:/var/www/sites/augeas.et.redhat.com/
clean:
	rm -rf $(BUILD)

.PHONY: rest2web sync clean naturaldocs
