require 'spec_helper'
require 'plugins/pre-commit/message/formatter'
require 'plugins/pre-commit/domain/checkstyle'
require 'plugins/pre-commit/domain/bad_file'

##
# Tests for PreCommit::Message::Formatter
describe PreCommit::Message::Formatter do
  let(:formatter) { PreCommit::Message::Formatter.new }

  let(:file_error) {
    Domain::BadFile.new('/some/path/file_name.java',
    [{
      "line"=>"1",
      "severity"=>"error",
      "message"=>"some error message",
      "source"=>"com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck"
    }])
  }

  let(:file_error_2) {
    Domain::BadFile.new('/some/path/file_name2.java',
    [{
      "line"=>"11",
      "column"=>"40",
      "severity"=>"error",
      "message"=>"some error message",
      "source"=>"com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck"
    }])

  }

  context "When has empty input" do
    it {expect{ formatter.format(nil) }.to raise_error(ArgumentError)}
  end

  context "When has no errors" do
    let(:good) { Domain::Checkstyle.good }
    it { expect(formatter.format(good)).to be_nil }
  end

  context "When has one file" do
    let(:errors) { Domain::Checkstyle.new( [ file_error ] ) }

    it{ expect(formatter.format(errors)).to include "File errors: /some/path/file_name.java"}
    it{ expect(formatter.format(errors)).to include "  line: 1: error: some error message"}
  end

  context "When has more than one file" do
    let(:errors) do
      Domain::Checkstyle.new( [ file_error, file_error_2 ] )
    end

    it{ expect(formatter.format(errors)).to include "File errors: /some/path/file_name.java"}
    it{ expect(formatter.format(errors)).to include "  line: 1: error: some error message"}
    it{ expect(formatter.format(errors)).to include "File errors: /some/path/file_name2.java"}
    it{ expect(formatter.format(errors)).to include "  line: 11:40 error: some error message"}
  end
end
