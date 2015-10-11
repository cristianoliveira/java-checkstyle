require 'spec_helper'
require 'plugins/pre_commit/message/formatter'
##
# Tests for PreCommit::Message::Formatter
describe PreCommit::Message::Formatter do
  let(:formatter) { PreCommit::Message::Formatter.new }

  context "When has empty input" do
    it {expect{ formatter.format(nil) }.to raise_error(ArgumentError)}
    it {expect{ formatter.format('') }.to raise_error(ArgumentError)}
  end

  context "When has no errors" do
    let(:errors) { { 'checkstyle' => { 'file' => [] } } }
    it { expect(formatter.format(errors)).to be_nil }
  end

  context "When has one file" do
    let(:errors) do
      { 'checkstyle' => {
          'file' => {
            'name' => '/some/path/file_name.java',
            'error' => [{
              "line"=>"1",
              "column"=>"40",
              "severity"=>"error",
              "message"=>"some error message",
              "source"=>"com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck"
            }]
          }
        }
      }
    end

    it{ expect(formatter.format(errors)).to include "File errors: /some/path/file_name.java"}
    it{ expect(formatter.format(errors)).to include "  line: 1:40 error: some error message"}
  end

  context "When has more than one file" do
    let(:errors) do
      { 'checkstyle' => {
          'file' => [
            {
              'name' => '/some/path/file_name.java',
              'error' => [{
                "line"=>"1",
                "severity"=>"error",
                "message"=>"some error message",
                "source"=>"com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck"
              }]
            },
            {
              'name' => '/some/path/file_name2.java',
              'error' => [{
                "line"=>"11",
                "column"=>"40",
                "severity"=>"error",
                "message"=>"some error message",
                "source"=>"com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck"
              }]
            }
          ]
        }
      }
    end

    it{ expect(formatter.format(errors)).to include "File errors: /some/path/file_name.java"}
    it{ expect(formatter.format(errors)).to include "  line: 1: error: some error message"}
    it{ expect(formatter.format(errors)).to include "File errors: /some/path/file_name2.java"}
    it{ expect(formatter.format(errors)).to include "  line: 11:40 error: some error message"}
  end
end
