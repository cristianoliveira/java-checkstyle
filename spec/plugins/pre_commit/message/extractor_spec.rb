require 'spec_helper'
require 'plugins/pre_commit/message/extractor'
##
# Tests for PreCommit::Message::Extractor
describe PreCommit::Message::Extractor do
  let(:extractor) { PreCommit::Message::Extractor.new }

  context "empty output" do
    it "should return empty file for nil output" do
      result = extractor.extract nil
      expect(result['checkstyle']['file']).to be_empty
    end

    it "should return empty file for empty output" do
      result = extractor.extract ''
      expect(result['checkstyle']['file']).to be_empty
    end
  end

  context "has one bad file" do
    # given
    let(:output) { IO.read(fixture_file("output_one_bad_file.log")) }

    it "should contain one single file" do
      result = extractor.extract output
      expect(result['checkstyle']['file']).to be_a Hash
    end

    it "should contain its errors" do
      result = extractor.extract output
      expect(result['checkstyle']['file']['error'].size).to eq 2
    end

    it "should extract error details" do
      expected = [
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

      result = extractor.extract output
      errors = result['checkstyle']['file']['error']
      expect(errors).to eq expected
    end
  end

  context "has multiple bad files" do
    let(:output) { IO.read(fixture_file("output_two_bad_files.log")) }

    it "should extract multiple files" do
      result = extractor.extract output
      expect(result['checkstyle']['file']).to be_a Array
    end

    it "should extract their errors" do
      result = extractor.extract output
      expect(result['checkstyle']['file'][0]['error'].size).to eq 2
      expect(result['checkstyle']['file'][1]['error'].size).to eq 2
    end

    it "should extract error details" do
      expected = [
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

      result = extractor.extract output
      errors = result['checkstyle']['file'][0]['error']
      expect(errors).to eq expected
    end
  end
end
