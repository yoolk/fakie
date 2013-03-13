require 'test_helper'

module Fakie
  class SpotTest < TestCase
    def test_fr
      phone_number = PhoneNumber.parse('+33 06 61 25 00 00')
      assert_equal 'FR', phone_number.region_code
    end

    def test_hk
      phone_number = PhoneNumber.parse('+852 9160 0000')
      assert_equal 'HK', phone_number.region_code
    end

    def test_at
      phone_number = PhoneNumber.parse('+43 680 233 0000')
      assert_equal 'AT', phone_number.region_code
    end

    def test_ch
      phone_number = PhoneNumber.parse('+41 79 667 00 00')
      assert_equal 'CH', phone_number.region_code
    end

    def test_es
      phone_number = PhoneNumber.parse('+34693600000')
      assert_equal 'ES', phone_number.region_code
    end
  end
end
