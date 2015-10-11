require 'spec_helper'
require 'plugins/pre_commit/message/extractor'
##
# Tests for PreCommit::Message::Extractor
describe PreCommit::Message::Extractor do
  let(:extractor) { PreCommit::Message::Extractor.new }
  let(:output) {
'<?xml version="1.0" encoding="UTF-8"?>
  <checkstyle version="6.11">
     <file name="/Users/cristianoliveira/work/java-checkstyle/spec/fixtures/bad.java">
       <error line="1" severity="error" message="some error message" source="com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocTypeCheck"/>
       <error line="11" column= "1 " severity= "warning" message="some error message" source="com.puppycrawl.tools.checkstyle.checks.design.HideUtilityClassConstructorCheck"/>
    </file>
    <file name="/Users/cristianoliveira/work/java-checkstyle/spec/fixtures/bad2.java">
       <error line="2 " column= "3 " severity= "error" message="some error message" source= "com.puppycrawl.tools.checkstyle.checks.javadoc.JavadocMethodCheck "/>
       <error line="2 " column= "27 " severity= "error" message="some error message" source= "com.puppycrawl.tools.checkstyle.checks.FinalParametersCheck "/>
    </file>
  </checkstyle>
Checkstyle ends with 4 errors.' }
  
  it "should return nil for empty output" do
    output = nil
    result = extractor.extract output

    expect(result).to be_nil
  end

  it "should extract files" do
    result = extractor.extract output
    expect(result['checkstyle']['file'].size).to eq 2
  end

  it "should extract errors" do
    result = extractor.extract output
    expect(result['checkstyle']['file'][0]['error'].size).to eq 2
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
