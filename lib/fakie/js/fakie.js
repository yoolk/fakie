var Fakie = {
  parse: function(phoneNumber, regionCode) {
    var phoneUtil = i18n.phonenumbers.PhoneNumberUtil.getInstance();
    var number = phoneUtil.parseAndKeepRawInput(phoneNumber, regionCode);
    var serialized = new goog.proto2.ObjectSerializer(goog.proto2.ObjectSerializer.KeyOption.NAME).serialize(number)
    return serialized;
  }
};
