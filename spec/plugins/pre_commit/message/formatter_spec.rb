require 'spec_helper'
require 'plugins/pre_commit/message/formatter'
require 'plugins/pre_commit/domain/checkstyle'
require 'plugins/pre_commit/domain/bad_file'

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

    before { @formatted_output = formatter.format(errors)}

    it{ expect( @formatted_output ).to include "File errors: /some/path/file_name.java"}
    it{ expect( @formatted_output ).to include "  line: 1: error: some error message"}
  end

  context "When has more than one file" do
    let(:errors) do
      Domain::Checkstyle.new( [ file_error, file_error_2 ] )
    end

    before { @formatted_output = formatter.format(errors) }

    it{ expect( @formatted_output ).to include "File errors: /some/path/file_name.java"}
    it{ expect( @formatted_output ).to include "  line: 1: error: some error message"}
    it{ expect( @formatted_output ).to include "File errors: /some/path/file_name2.java"}
    it{ expect( @formatted_output ).to include "  line: 11:40 error: some error message"}
  end
end
