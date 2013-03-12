module Fakie
  class PhoneNumber
    include JavaScript

    class << self
      include JavaScript

      # Parse a phone number
      # @param phone_number [String] phone number to parse
      # @option options default_country [String] ISO 3166-1 two-letter country code
      # @return [PhoneNumber] phone number object
      def parse(phone_number, options = {})
        region_code = options[:default_country]
        self.new(js_call('Fakie.parse', phone_number, region_code))
      end
    end

    attr_reader :country_code
    attr_reader :national_number
    attr_reader :raw_input
    attr_reader :country_code_source
    attr_reader :preferred_domestic_carrier_code
    attr_reader :region_code
    attr_reader :type

    # @param hash [Hash] hash of phone number data
    def initialize(hash)
      @country_code = hash['country_code']
      @national_number = hash['national_number']
      @raw_input = hash['raw_input']
      @country_code_source = hash['country_code_source']
      @preferred_domestic_carrier_code = hash['preferred_domestic_carrier_code']
      @is_possible = hash['is_possible']
      @is_valid = hash['is_valid']
      @region_code = hash['region']
      @type = hash['type']
    end

    def is_possible?
      @is_possible
    end

    def is_valid?
      @is_valid
    end

    def e164_format
      raise InvalidPhoneNumber unless self.is_valid?
      @e164_format ||= js_call('Fakie.formatE164', self.region_code, self.raw_input)
    end

    def international_format
      raise InvalidPhoneNumber unless self.is_valid?
      @international_format ||= js_call('Fakie.formatInternation', self.region_code, self.raw_input)
    end

    def local_format
      raise InvalidPhoneNumber unless self.is_valid?
      @local_format ||= js_call('Fakie.formatLocal', self.region_code, self.raw_input)
    end

    def country_name
      return nil unless self.region_code
      @country_name ||= js_call('Fakie.countryCodeToName', self.region_code)
    end
  end
end

