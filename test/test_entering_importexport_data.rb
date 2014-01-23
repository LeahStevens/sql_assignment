require_relative 'helper'

class Testing < MiniTest::Unit::TestCase
  def testing_start
    expected = 0
    assert_equal 0, expected
  end
end
