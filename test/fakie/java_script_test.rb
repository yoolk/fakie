require 'test_helper'

module Fakie
  class JavaScriptTest < TestCase
    def test_eval
      assert_equal '415', JavaScript.eval('Fakie.parse("+14155550123")["area_code"]')
    end
  end
end
