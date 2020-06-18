git pull
git submodule init
git submodule update
	
rm -rf ~/tmp/java/
mkdir -p ~/tmp/java/
cp common/docbook.css ~/tmp/java/
xsltproc -o ~/tmp/java/ docbook-xsl/docbook.mac.xsl book.xml
