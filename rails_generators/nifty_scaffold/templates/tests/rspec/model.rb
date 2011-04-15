require File.dirname(__FILE__) + '/../spec_helper'

describe <%= model_name %> do
  it "should be valid" do
    <%= model_name %>.new.should be_valid
  end
end
