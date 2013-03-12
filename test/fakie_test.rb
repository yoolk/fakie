require 'test_helper'

module Fakie
  class FakieTest < TestCase
    def test_parse
      assert_kind_of PhoneNumber, Fakie.parse('+14155550123')
    end
  end
end
