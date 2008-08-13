require File.dirname(__FILE__) + '/../spec_helper'

describe <%= class_name %> do
  it "should be valid" do
    <%= class_name %>.new.should be_valid
  end
end
