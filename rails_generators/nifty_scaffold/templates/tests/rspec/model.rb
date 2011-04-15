require File.dirname(__FILE__) + '<%= model_name.underscore.gsub(/[^\/]+/, '/..') %>/spec_helper'

describe <%= model_name %> do
  it "should be valid" do
    <%= model_name %>.new.should be_valid
  end
end
