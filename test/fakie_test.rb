require 'test_helper'

module Fakie
  class FakieTest < TestCase
    def test_parse
      assert_kind_of PhoneNumber, Fakie.parse('+14155550123')
    end

    def test_invalid_country
      refute Fakie.country_name_for_region_code('ZZ')
    end

    def test_default_options
      refute Fakie.parse('4155550123').is_valid?

      Fakie.default_options = { :default_country => 'US' }
      assert Fakie.parse('4155550123').is_valid?
      Fakie.default_options = nil
    end
  end
end
