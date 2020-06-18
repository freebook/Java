#rm -rf ~/tmp/spring/
mkdir -p ~/tmp/spring/
cp ../common/docbook.css ~/tmp/spring/
xsltproc -o ~/tmp/spring/ ../docbook-xsl/docbook.mac.xsl book.xml
