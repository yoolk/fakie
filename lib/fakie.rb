require 'fakie/version'
require 'fakie/errors'
require 'fakie/java_script'
require 'fakie/phone_number'

module Fakie
  module_function

  # Parse a phone number
    # @param phone_number [String] phone number to parse
    # @option options default_country [String] ISO 3166-1 two-letter country code
    # @return [PhoneNumber] phone number object
    def parse(phone_number, options = {})
      PhoneNumber.parse(phone_number, options)
    end
end
