import 'package:flutter/services.dart';

class AppConstants {
  AppConstants();

  static final RegExp emailValidator =
      RegExp(r'^[a-zA-Z0-9._-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
  static final RegExp passwordValidatorRegExp =
      RegExp(r'/^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])[A-Za-z0-9]{6,}$/');
  static const String kEmailNullError = 'Please Enter your email';
  static const String kInvalidEmailError = 'Please Enter Valid Email';
  static const String kPassNullError = 'Please Enter your password';
  static const String kShortPassError =
      'Password must contain at least 8 characters';
  static const String kMatchPassError = 'Passwords does not match';
  static const String firstnameNullError = 'First name must not be empty';
  static const String lastnameNullError = 'Last name must not be empty';
  static const String kIvalidPasswordError =
      'Password must contain at least one uppercase, lowercase and number';
  static const String kNamelNullError = 'Please Enter your name';
  static const String kPhoneNumberNullError = 'Please Enter your phone number';
  static const String kInvalidPhoneNumberError =
      'Please Enter valid phone number';
  static const String kAddressNullError = 'Please Enter your address';
  static final RegExp phoneValidatorRegExp =
      RegExp(r'^[+]*[(]{0,1}[0-9]{1,4}[)]{0,1}[-\s\./0-9]*$');
  static const String passwordMustContainLowercase =
      'Password must contain at least one lowercase character';
  static const String passwordMustContainUppercase =
      'Password must contain at least one uppercase character';
  static const String passwordMustContainNumber =
      'Password must contain at least one number';
  static const String invalidDealName = 'Invalid deal name';
  static const String genderRequired = 'Gender is  required';
  static const String languageCode = 'en';
  static const String countryCode = 'NG';

  static List<TextInputFormatter> numberInputFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(
      RegExp(r'[0-9]'),
    ),
    FilteringTextInputFormatter.deny(RegExp(r'^0+')),
  ];
  static List<TextInputFormatter> decimalFormatter = <TextInputFormatter>[
    FilteringTextInputFormatter.allow(RegExp(r'^\d+(\.\d*)?')),
  ];

  static const Duration networkTimeOut = Duration(seconds: 90);
}
