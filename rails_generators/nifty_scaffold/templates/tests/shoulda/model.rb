require 'test_helper'

class <%= class_name %>Test < ActiveSupport::TestCase
  should "be valid"
    assert <%= class_name %>.new.valid?
  end
end
