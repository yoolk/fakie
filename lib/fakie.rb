require 'fakie/version'

module Fakie
  module_function

  def format_e164(country, phone_number)
    js('formatE164', country, phone_number)
  end

  def format_local(country, phone_number)
    js('formatLocal', country, phone_number)
  end

  def format_international(country, phone_number)
    js('formatInternational', country, phone_number)
  end

  def country_for_e164(phone_number)
    js('countryForE164Number', phone_number)
  end

  def country_code_to_name(country)
    js('countryCodeToName', country)
  end

  def js(function, *args)
    @@context ||= begin
      require 'execjs'
      source = File.open('lib/fakie/data/PhoneFormat.js').read
      ExecJS.compile(source)
    end

    @@context.call(function, *args)
  end
end
