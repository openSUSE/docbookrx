require 'nokogiri'
require 'minitest/autorun'

class SuseXmlTest < MiniTest::Spec
  def self.prepare 
    toplevel = File.dirname File.dirname __FILE__
    @@asciidoctor_xml = File.expand_path(File.join(toplevel,"asciidoctor", "xml", "MAIN-set.xml"))

    puts "Read #{@@asciidoctor_xml.inspect}"
    @@xml = ::Nokogiri::XML.parse(File.read(@@asciidoctor_xml))
  end
  prepare

  xml = @@xml # syntactic sugar
  xml.remove_namespaces! # xpath would be /xmlns:book/xmlns:... otherwise
  root = xml.root

  describe "SUSE XML tags" do
    #
    # overall format
    #
    describe "docbook xml" do
      it "is readable" do
        assert File.readable? @@asciidoctor_xml
      end
      it "is XML" do
        assert_equal ::Nokogiri::XML::Document, xml.class 
      end
      it "is a <book>" do
        root.name.must_equal "book"
      end
    end

    #
    # internal structure
    #
    describe "internal structure" do
      it "has a <info> section" do
        assert xml.at_xpath('/book/info')
      end
      it "has a <preface> section" do
        assert xml.at_xpath('/book/preface')
      end
      it "has a <part> section" do
        assert xml.at_xpath('/book/part')
      end
    end

    #
    # info section
    #
    describe "info section" do
      it "has a title" do
        assert xml.at_xpath("/book/info/title")
      end
      it "has a title 'A Set of Books'" do
        title =  xml.at_xpath("/book/info/title")
        assert_equal 'A Set of Books', title.text
      end
      it "has a date" do
        assert xml.at_xpath("/book/info/date")
      end
    end
    #
    # preface section
    # asciidoctor converts info > abstract into preface > abstract
    #
    describe "preface section" do
      it "has an abstract" do
        assert xml.at_xpath("/book/preface/abstract")
      end
    end
    #
    # part section
    #
    describe "part section" do
      it "has a title" do
        assert xml.at_xpath("/book/part/title")
      end
      it "has a title 'Book One'" do
        title =  xml.at_xpath("/book/part/title")
        assert_equal 'Book One', title.text
      end
    end
  end
end