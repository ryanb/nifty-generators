require 'test_helper'

class <%= model_name %>Test < ActiveSupport::TestCase
  def test_should_be_valid
    assert <%= model_name %>.new.valid?
  end
end
