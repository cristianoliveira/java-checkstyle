require 'spec_helper'
require 'plugins/pre_commit/checks/checkstyle'

describe PreCommit::Checks::Checkstyle do
  let(:config) {double(PreCommit::Configuration, get: '')}
  let(:custom_config) {double(PreCommit::Configuration,
                              get: '/home/alex/Development/java-checkstyle/lib/pre-commit/support/checkstyle/google_checks.xml')}
  let(:check) {PreCommit::Checks::Checkstyle.new(nil, config, [])}
  let(:custom_check) {PreCommit::Checks::Checkstyle.new(nil, custom_config, [])}

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
    #{file}:1: error: Missing a Javadoc comment.
    #{file}:1:1: error: Utility classes should not have a public or default constructor.
    #{file}:2:3: error: Missing a Javadoc comment.
    #{file}:2:27: error: Parameter args should be final.
Audit done.
Checkstyle ends with 4 errors.
    ERROR
  end

  it "should accept custom checkstyle" do
    # given
    files = [fixture_file('good.java')]
    # when
    # then
    expect(custom_check.call(files)).to be_nil
  end

end
