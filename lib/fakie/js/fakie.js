var Fakie = {
  parse: function(phoneNumber, regionCode) {
    var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();
    var number = phoneUtil.parseAndKeepRawInput(phoneNumber, regionCode);
    var result = new goog.proto2.ObjectSerializer(goog.proto2.ObjectSerializer.KeyOption.NAME).serialize(number)

    var isPossible = phoneUtil.isPossibleNumber(number);
    result['is_possible'] = isPossible;

    if (!isPossible) {
      var PNV = i18n.phonenumbers.PhoneNumberUtil.ValidationResult;
      switch (phoneUtil.isPossibleNumberWithReason(number)) {
        case PNV.INVALID_COUNTRY_CODE:
          result['invalid_reason'] = 'INVALID_COUNTRY_CODE'
          break;
        case PNV.TOO_SHORT:
          result['invalid_reason'] = 'TOO_SHORT';
          break;
        case PNV.TOO_LONG:
          result['invalid_reason'] = 'TOO_LONG';
          break;
        }
    } else {
      var isNumberValid = phoneUtil.isValidNumber(number);
      result['is_valid'] = isNumberValid;

      if (isNumberValid && regionCode && regionCode != 'ZZ') {
        result['is_valid_for_region'] = phoneUtil.isValidNumberForRegion(number, regionCode);
      }

      result['region'] = phoneUtil.getRegionCodeForNumber(number);
      var PNT = i18n.phonenumbers.PhoneNumberType;
      switch (phoneUtil.getNumberType(number)) {
        case PNT.FIXED_LINE:
          result['type'] = 'FIXED_LINE';
          break;
        case PNT.MOBILE:
          result['type'] = 'MOBILE';
          break;
        case PNT.FIXED_LINE_OR_MOBILE:
          result['type'] = 'FIXED_LINE_OR_MOBILE';
          break;
        case PNT.TOLL_FREE:
          result['type'] = 'TOLL_FREE';
          break;
        case PNT.PREMIUM_RATE:
          result['type'] = 'PREMIUM_RATE';
          break;
        case PNT.SHARED_COST:
          result['type'] = 'SHARED_COST';
          break;
        case PNT.VOIP:
          result['type'] = 'VOIP';
          break;
        case PNT.PERSONAL_NUMBER:
          result['type'] = 'PERSONAL_NUMBER';
          break;
        case PNT.PAGER:
          result['type'] = 'PAGER';
          break;
        case PNT.UAN:
          result['type'] = 'UAN';
          break;
        case PNT.UNKNOWN:
          result['type'] = 'UNKNOWN';
          break;
      }
    }

    result['e164'] = phoneUtil.format(number, i18n.phonenumbers.PhoneNumberFormat.E164);

    return result;
  },

  countryForE164Number: function(phone) {
    try {
    var phone = Fakie.cleanPhone(phone);
    var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();
    var number = phoneUtil.parseAndKeepRawInput(phone);
      return phoneUtil.getRegionCodeForNumber(number);
    } catch (e) {
      return "";
    }
  },

  formatE164: function(country, phone) {
    try {
    var phone = Fakie.cleanPhone(phone);
    var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();
    var number = phoneUtil.parseAndKeepRawInput(phone, country);
    var PNF = i18n.phonenumbers.PhoneNumberFormat;
      return phoneUtil.format(number, PNF.E164);
    } catch (e) {
      return phone;
    }
  },

  formatInternational: function(country, phone) {
    try {
    var phone = Fakie.cleanPhone(phone);
      var formatter = new i18n.phonenumbers.AsYouTypeFormatter(country);
      var output = new goog.string.StringBuffer();
      for (var i = 0; i < phone.length; ++i) {
        var inputChar = phone.charAt(i);
        output = (formatter.inputDigit(inputChar));
      }
      return output.toString();
    } catch (e) {
      return phone;
    }
  },

  formatLocal: function(country, phone) {
    try {
      var phone = Fakie.cleanPhone(phone);
      var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();
      var number = phoneUtil.parseAndKeepRawInput(phone, country);
      if (phoneUtil.isValidNumberForRegion(number, country)) {
        var PNF = i18n.phonenumbers.PhoneNumberFormat;
        return phoneUtil.format(number, PNF.NATIONAL);
      } else {
        return Fakie.formatInternational(country, phone);
      }
    } catch (e) {
      return Fakie.formatInternational(country, phone);
    }
  },

  cleanPhone: function(phone) {
    phone = phone.replace(/[^\d\+]/g,'');
    if (phone.substr(0, 1) == "+") {
      phone = "+" + phone.replace(/[^\d]/g,'');
    } else {
      phone = phone.replace(/[^\d]/g,'');
    }
    return phone;
  }
};
