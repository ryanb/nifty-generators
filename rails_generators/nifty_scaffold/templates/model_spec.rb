require File.dirname(__FILE__) + '/../spec_helper'

describe <%= class_name %> do
  before(:each) do
    @<%= singular_name %> = <%= class_name %>.new
  end
  
  it "should be valid" do
    @<%= singular_name %>.should be_valid
  end
end
