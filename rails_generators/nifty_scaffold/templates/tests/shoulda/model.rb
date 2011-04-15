require 'test_helper'

class <%= model_name %>Test < ActiveSupport::TestCase
  should "be valid" do
    assert <%= model_name %>.new.valid?
  end
end
