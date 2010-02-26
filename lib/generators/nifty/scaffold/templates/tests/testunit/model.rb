require 'test_helper'

class <%= class_name %>Test < ActiveSupport::TestCase
  def test_should_be_valid
    assert <%= class_name %>.new.valid?
  end
end
