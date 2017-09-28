require 'spec_helper'
require 'plugins/pre_commit/message/extractor'
require 'plugins/pre_commit/domain/checkstyle'
require 'plugins/pre_commit/domain/bad_file'

##
# Tests for PreCommit::Message::Extractor
describe PreCommit::Message::Extractor do
  let(:extractor) { PreCommit::Message::Extractor.new }

  context "When nil output" do
    it "should be good" do
      expect( extractor.extract(nil) ).to be_good
    end
  end

  context "When empty output" do
    it "should be good" do
      expect( extractor.extract('') ).to be_good
    end
  end

  context "When has one bad file" do
    # given
    let(:output) { IO.read(fixture_file("output_one_bad_file.log")) }

    # when
    before { @checkstyle = extractor.extract(output) }

    # then
    it "should not be good" do
      expect( @checkstyle ).to_not be_good
    end

    it "should contain one single file" do
      expect( @checkstyle.bad_files ).to be_a Array
    end

    it "should contain its errors" do
      expect( @checkstyle.bad_files[0].errors.size ).to be 2
    end

    it "should extract error details" do
      expect( @checkstyle.bad_files[0].errors ).to eq(
        [
          {
            "line"=>"1",
            "severity"=>"error",
            "message"=>"some error message",
            "source"=>"com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck"
          },
          {
            "line" => "11",
            "column" => "1 ",
            "severity" => "warning",
            "message" => "some error message",
            "source" => "com.puppycrawl.tools.checkstyle.checks.design.HideUtilityClassConstructorCheck"
          }
        ]
      )
    end
  end

  context "When has multiple bad files" do
    # given
    let(:output) { IO.read(fixture_file("output_two_bad_files.log")) }

    # when
    before { @checkstyle = extractor.extract output }

    # then
    it "should not be good" do
      expect( @checkstyle ).to_not be_good
    end

    it "should extract multiple files" do
      expect( @checkstyle.bad_files ).to be_a Array
    end

    it "should extract their errors" do
      expect( @checkstyle.bad_files[0].errors.size ).to be 2
      expect( @checkstyle.bad_files[1].errors.size ).to be 2
    end

    it "should extract error details" do
      expect( @checkstyle.bad_files[0].errors ).to eq ([
          {
            "line"=>"1",
            "severity"=>"error",
            "message"=>"some error message",
            "source"=>"com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck"
          },
          {
            "line" => "11",
            "column" => "1 ",
            "severity" => "warning",
            "message" => "some error message",
            "source" => "com.puppycrawl.tools.checkstyle.checks.design.HideUtilityClassConstructorCheck"
          }
      ])
    end
  end
end
