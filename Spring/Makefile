XSLTPROC=/usr/bin/xsltproc
DSSSL=../docbook-xsl/docbook.xsl
TMPDIR=$(shell mktemp -d --suffix=.tmp -p /tmp centos.html.XXXXXX)
WORKSPACE=~/workspace
PROJECT=Java/Spring
DOCBOOK=spring
PUBLIC_HTML=~/public_html
PROJECT_DIR=$(WORKSPACE)/$(PROJECT)
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
	@${XSLTPROC} -o $(HTMLHELP_DIR)/ --stringparam htmlhelp.chm ../NetkillerSpirngCloud.chm ../../docbook-xsl/htmlhelp/template.xsl book.xml
	@test -f $(HTMLHELP_DIR)/htmlhelp.hhp && ../../common/chm.sh $(HTMLHELP_DIR)
	@iconv -f UTF-8 -t GB18030 -o $(HTMLHELP_DIR)/htmlhelp.hhp < $(HTMLHELP_DIR)/htmlhelp.hhp
	@iconv -f UTF-8 -t GB18030 -o $(HTMLHELP_DIR)/toc.hhc < $(HTMLHELP_DIR)/toc.hhc
	
rpm:
	rpmbuild -ba --sign ../Miscellaneous/package/package.spec --define "book $(DOCBOOK)"
	rpm -qpi ~/rpmbuild/RPMS/x86_64/netkiller-$(DOCBOOK)-*.x86_64.rpm
	rpm -qpl ~/rpmbuild/RPMS/x86_64/netkiller-$(DOCBOOK)-*.x86_64.rpm

epub:

	DSSSL=../docbook-xsl/epub3.xsl
	XSLTPROC="xsltproc --stringparam epub.stylesheet docbook.css --stringparam use.id.as.filename 1 ${DSSSL}"
	PROJECT="Netkiller-Spring"
	EPUB=$PUBLIC_HTML/download/$(date '+%Y')/epub/
	IMAGES=${WORKSPACE}/Java/images
	#echo $PROJECT
	#echo $EPUB
	mkdir -p ${EPUB}

	TMPDIR=$(mktemp -d --suffix=.tmp -p /tmp epub.$2.XXXXXX)
	echo $TMPDIR
	cd $TMPDIR
	
	${XSLTPROC} $PROJECT_DIR/book.xml

	if [ -d ${IMAGES} ]; then
		rsync -a ${IMAGES} OEBPS/
		rsync -a $WORKSPACE/Website/images/book/* OEBPS/images/
	fi
	#find OEBPS -type d -iname ".svn" -exec rm -rf {} \; 

	echo "application/epub+zip" > mimetype
	zip -0Xq  ${PROJECT}.epub mimetype
	zip -Xr9D ${PROJECT}.epub *

	cp *.epub ${EPUB}
	cd -

clean:
	rm -rf $(HTML)

test:
	@$(XSLTPROC) -o $(TMPDIR)/ $(DSSSL) $(PROJECT_DIR)/book.xml
