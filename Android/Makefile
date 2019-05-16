XSLTPROC = /usr/bin/xsltproc
DSSSL = ../../docbook-xsl/docbook.xsl
TMPDIR = $(shell mktemp -d --suffix=.tmp -p /tmp centos.html.XXXXXX)
WORKSPACE=~/workspace
PROJECT=Android
DOCBOOK=android
PUBLIC_HTML=~/public_html
PROJECT_DIR=$(WORKSPACE)/Java/$(PROJECT)
HTML_DIR=$(PUBLIC_HTML)/$(DOCBOOK)
HTMLHELP_DIR=~/htmlhelp/$(DOCBOOK)/htmlhelp

all: html htmlhelp rpm

html:
	@mkdir -p ${HTML_DIR}
	@find ${HTML_DIR} -type f -iname "*.html" -exec rm -rf {} \;
	@rsync -au ../../common/docbook.css $(HTML_DIR)/
	@$(XSLTPROC) -o $(HTML_DIR)/ $(DSSSL) $(PROJECT_DIR)/book.xml
	@$(shell test -d $(HTML_DIR)/images && find $(HTML_DIR)/images/ -type f -exec rm -rf {} \;)
	@$(shell test -d images && rsync -au --exclude=.svn $(PROJECT_DIR)/images $(HTML_DIR)/)

htmlhelp:
	@rm -rf $(HTMLHELP_DIR) && mkdir -p $(HTMLHELP_DIR)
	#@test -d $(PROJECT_DIR)/images && rsync -a images $(HTMLHELP_DIR)
	@${XSLTPROC} -o $(HTMLHELP_DIR)/ --stringparam htmlhelp.chm ../Netkiller$(PROJECT).chm ../../docbook-xsl/htmlhelp/template.xsl book.xml
	@test -f $(HTMLHELP_DIR)/htmlhelp.hhp && ../../common/chm.sh $(HTMLHELP_DIR)
	
rpm:
	rpmbuild -ba --sign ../Miscellaneous/package/package.spec --define "book $(DOCBOOK)"
	rpm -qpi ~/rpmbuild/RPMS/x86_64/netkiller-$(DOCBOOK)-*.x86_64.rpm
	rpm -qpl ~/rpmbuild/RPMS/x86_64/netkiller-$(DOCBOOK)-*.x86_64.rpm

clean:
	rm -rf $(HTML)

test:
	@$(XSLTPROC) -o $(TMPDIR)/ $(DSSSL) $(PROJECT_DIR)/book.xml
