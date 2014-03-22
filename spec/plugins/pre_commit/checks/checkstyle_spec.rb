require 'spec_helper'
require 'plugins/pre_commit/checks/checkstyle'

describe PreCommit::Checks::Checkstyle do
  let(:config) {double(PreCommit::Configuration, get: '')}
  let(:check) {PreCommit::Checks::Checkstyle.new(nil, config, [])}

  it "succeds if nothing changed" do
    expect(check.call([])).to be_nil
  end

  it "succeeds for good code" do
    files = [fixture_file('good.java')]
    expect(check.call(files)).to be_nil
  end

  it "fails for bad formatted code" do
    file = fixture_file("bad.java")
    expect(check.call([file])).to eq <<-ERROR
Starting audit...
#{file}:1: Missing a Javadoc comment.
#{file}:1:1: Utility classes should not have a public or default constructor.
#{file}:2:3: Missing a Javadoc comment.
#{file}:2:27: Parameter args should be final.
Audit done.
ERROR
  end
end
