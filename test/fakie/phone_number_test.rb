require 'test_helper'

module Fakie
  class PhoneNumberTest < TestCase
    def test_parse
      phone_number = Fakie.parse('+1 415 555 0123')
      assert_equal 1, phone_number.country_code
      assert_equal 4155550123, phone_number.national_number
      assert_equal '415', phone_number.area_code
      assert_equal '+1 415 555 0123', phone_number.raw_input
      assert_equal '+14155550123', phone_number.e164
      assert_equal 'US', phone_number.region_code
      assert_equal 'United States', phone_number.country_name
      assert phone_number.is_possible?
      assert phone_number.is_valid?
    end

    def test_to_s
      phone_number = Fakie.parse('+14155550123')
      assert_equal phone_number.e164, phone_number.to_s
    end

    def test_parse_with_default_country
      phone_number = Fakie.parse('(415) 555-0123', :default_country => 'US')
      assert_equal 1, phone_number.country_code
      assert_equal 4155550123, phone_number.national_number
      assert_equal '(415) 555-0123', phone_number.raw_input
      assert_equal 'US', phone_number.region_code
      assert phone_number.is_possible?
      assert phone_number.is_valid?
    end

    def test_local_format
      phone_number = Fakie.parse('+1 415-555-0123')
      assert_equal '(415) 555-0123', phone_number.local_format
    end

    def test_international_format
      phone_number = Fakie.parse('+14155550123')
      assert_equal '+1 415-555-0123', phone_number.international_format

      phone_number = Fakie.parse('415-555-0123', :default_country => 'US')
      assert_equal '+1 415-555-0123', phone_number.international_format
    end
  end
end
