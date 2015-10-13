require 'spec_helper'
require 'plugins/pre-commit/message/extractor'
require 'plugins/pre-commit/domain/checkstyle'
require 'plugins/pre-commit/domain/bad_file'

##
# Tests for PreCommit::Message::Extractor
describe PreCommit::Message::Extractor do
  let(:extractor) { PreCommit::Message::Extractor.new }

  context "When nil output" do
    it "should be good" do
      result = extractor.extract nil
      expect(result).to be_good
    end
  end

  context "When empty output" do
    it "should be good" do
      result = extractor.extract ''
      expect(result).to be_good
    end
  end

  context "When has one bad file" do
    # given
    let(:output) { IO.read(fixture_file("output_one_bad_file.log")) }

    it "should not be good" do
      result = extractor.extract output
      expect(result).to_not be_good
    end

    it "should contain one single file" do
      result = extractor.extract output
      expect(result.bad_files).to be_a Array
    end

    it "should contain its errors" do
      result = extractor.extract output
      expect(result.bad_files[0].errors.size).to eq 2
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
      errors = result.bad_files[0].errors
      expect(errors).to eq expected
    end
  end

  context "When has multiple bad files" do
    let(:output) { IO.read(fixture_file("output_two_bad_files.log")) }

    it "should not be good" do
      result = extractor.extract output
      expect(result).to_not be_good
    end

    it "should extract multiple files" do
      result = extractor.extract output
      expect(result.bad_files).to be_a Array
    end

    it "should extract their errors" do
      result = extractor.extract output
      expect(result.bad_files[0].errors.size).to eq 2
      expect(result.bad_files[1].errors.size).to eq 2
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

      expect(result.bad_files[0].errors).to eq expected
    end
  end
end
