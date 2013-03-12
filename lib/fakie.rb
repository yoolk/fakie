require 'fakie/version'

module Fakie
  module_function

  # Parse a phone number
  # @param phone_number [String] phone  number to parse
  # @option options country [String] ISO 3166-1 two-letter country code
  def parse(phone_number, options = {})
    region_code = options[:country]
    js_call('Fakie.parse', phone_number, region_code)
  end

  # var $ = goog.dom.getElement;
  # var phoneNumber = $('phoneNumber').value;
  # var regionCode = $('defaultCountry').value;
  # var carrierCode = $('carrierCode').value;
  # var output = new goog.string.StringBuffer();
  # try {
  #   var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();
  #   var number = phoneUtil.parseAndKeepRawInput(phoneNumber, regionCode);
  #   output.append('****Parsing Result:****\n');
  #   output.append(goog.json.serialize(new goog.proto2.ObjectSerializer(
  #       goog.proto2.ObjectSerializer.KeyOption.NAME).serialize(number)));


  #   output.append('\n\n****Validation Results:****');
  #   var isPossible = phoneUtil.isPossibleNumber(number);
  #   output.append('\nResult from isPossibleNumber(): ');
  #   output.append(isPossible);
  #   if (!isPossible) {
  #     output.append('\nResult from isPossibleNumberWithReason(): ');
  #     var PNV = i18n.phonenumbers.PhoneNumberUtil.ValidationResult;
  #     switch (phoneUtil.isPossibleNumberWithReason(number)) {
  #       case PNV.INVALID_COUNTRY_CODE:
  #         output.append('INVALID_COUNTRY_CODE');
  #         break;
  #       case PNV.TOO_SHORT:
  #         output.append('TOO_SHORT');
  #         break;
  #       case PNV.TOO_LONG:
  #         output.append('TOO_LONG');
  #         break;
  #       }
  #       // IS_POSSIBLE shouldn't happen, since we only call this if _not_
  #       // possible.
  #       output.append('\nNote: numbers that are not possible have type ' +
  #           'UNKNOWN, an unknown region, and are considered invalid.');
  #   } else {
  #     var isNumberValid = phoneUtil.isValidNumber(number);
  #     output.append('\nResult from isValidNumber(): ');
  #     output.append(isNumberValid);
  #     if (isNumberValid && regionCode && regionCode != 'ZZ') {
  #       output.append('\nResult from isValidNumberForRegion(): ');
  #       output.append(phoneUtil.isValidNumberForRegion(number, regionCode));
  #     }
  #     output.append('\nPhone Number region: ');
  #     output.append(phoneUtil.getRegionCodeForNumber(number));
  #     output.append('\nResult from getNumberType(): ');
  #     var PNT = i18n.phonenumbers.PhoneNumberType;
  #     switch (phoneUtil.getNumberType(number)) {
  #       case PNT.FIXED_LINE:
  #         output.append('FIXED_LINE');
  #         break;
  #       case PNT.MOBILE:
  #         output.append('MOBILE');
  #         break;
  #       case PNT.FIXED_LINE_OR_MOBILE:
  #         output.append('FIXED_LINE_OR_MOBILE');
  #         break;
  #       case PNT.TOLL_FREE:
  #         output.append('TOLL_FREE');
  #         break;
  #       case PNT.PREMIUM_RATE:
  #         output.append('PREMIUM_RATE');
  #         break;
  #       case PNT.SHARED_COST:
  #         output.append('SHARED_COST');
  #         break;
  #       case PNT.VOIP:
  #         output.append('VOIP');
  #         break;
  #       case PNT.PERSONAL_NUMBER:
  #         output.append('PERSONAL_NUMBER');
  #         break;
  #       case PNT.PAGER:
  #         output.append('PAGER');
  #         break;
  #       case PNT.UAN:
  #         output.append('UAN');
  #         break;
  #       case PNT.UNKNOWN:
  #         output.append('UNKNOWN');
  #         break;
  #     }
  #   }
  #   var PNF = i18n.phonenumbers.PhoneNumberFormat;
  #   output.append('\n\n****Formatting Results:**** ');
  #   output.append('\nE164 format: ');
  #   output.append(isNumberValid ?
  #                 phoneUtil.format(number, PNF.E164) :
  #                 'invalid');
  #   output.append('\nOriginal format: ');
  #   output.append(phoneUtil.formatInOriginalFormat(number, regionCode));
  #   output.append('\nNational format: ');
  #   output.append(phoneUtil.format(number, PNF.NATIONAL));
  #   output.append('\nInternational format: ');
  #   output.append(isNumberValid ?
  #                 phoneUtil.format(number, PNF.INTERNATIONAL) :
  #                 'invalid');
  #   output.append('\nOut-of-country format from US: ');
  #   output.append(isNumberValid ?
  #                 phoneUtil.formatOutOfCountryCallingNumber(number, 'US') :
  #                 'invalid');
  #   output.append('\nOut-of-country format from Switzerland: ');
  #   output.append(isNumberValid ?
  #                 phoneUtil.formatOutOfCountryCallingNumber(number, 'CH') :
  #                 'invalid');
  #   if (carrierCode.length > 0) {
  #     output.append('\nNational format with carrier code: ');
  #     output.append(phoneUtil.formatNationalNumberWithCarrierCode(number,
  #                                                                 carrierCode));
  #   }
  #   output.append('\n\n****AsYouTypeFormatter Results****');
  #   var formatter = new i18n.phonenumbers.AsYouTypeFormatter(regionCode);
  #   var phoneNumberLength = phoneNumber.length;
  #   for (var i = 0; i < phoneNumberLength; ++i) {
  #     var inputChar = phoneNumber.charAt(i);
  #     output.append('\nChar entered: ');
  #     output.append(inputChar);
  #     output.append(' Output: ');
  #     output.append(formatter.inputDigit(inputChar));
  #   }
  # } catch (e) {
  #   output.append('\n' + e);
  # }
  # $('output').value = output.toString();
  # return false;

  def js_context
    @@context ||= begin
      require 'execjs'
      source = File.open('lib/fakie/js/libphonenumber.js').read
      source += File.open('lib/fakie/js/fakie.js').read
      ExecJS.compile(source)
    end
  end

  def js_call(function, *args)
    js_context.call(function, *args)
  end

  def js_eval(script)
    js_context.eval(script)
  end
end
