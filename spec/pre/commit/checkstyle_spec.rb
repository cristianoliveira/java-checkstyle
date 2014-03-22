require 'spec_helper'

describe Pre::Commit::Checkstyle do
  it 'should have a version number' do
    Pre::Commit::Checkstyle::VERSION.should_not be_nil
  end

  it 'should do something useful' do
    false.should be_true
  end
end
