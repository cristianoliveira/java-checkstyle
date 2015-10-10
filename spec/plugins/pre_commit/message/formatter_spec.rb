require 'spec_helper'
require 'plugins/pre_commit/message/formatter'

describe PreCommit::Message::Formatter do
  let(:formatter) { PreCommit::Message::Formatter.new }

  it "should format output" do

    expected = "/fixtures/bad.java :1: error: Missing a Javadoc comment.
    /fixtures/bad.java :1:1: error: Utility classes should not have a public or default constructor.
    /fixtures/bad.java :2:3: error: Missing a Javadoc comment.
    /fixtures/bad.java :2:27: error: Parameter args should be final."

    output =  "Starting audit...
    /fixtures/bad.java :1: error: Missing a Javadoc comment.
    /fixtures/bad.java :1:1: error: Utility classes should not have a public or default constructor.
    /fixtures/bad.java :2:3: error: Missing a Javadoc comment.
    /fixtures/bad.java :2:27: error: Parameter args should be final.
Audit done.
Checkstyle ends with 4 errors."

    result = formatter.format output

    expect(result).to eq expected
  end
end
