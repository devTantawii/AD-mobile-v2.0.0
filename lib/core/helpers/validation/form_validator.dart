import 'package:abudiyab/core/helpers/validation/validation.dart';
import 'package:flutter/cupertino.dart';

import '../../../language/locale.dart';

class FormValidator {
  static String? passwordValidate(BuildContext context , String? value) {
    final passwordValidator = Validate.validatePassword(context , value);
    if (passwordValidator == null) {
      return null;
    } else {
      return passwordValidator;
    }
  }

  static String? passwordConfirmValidate(BuildContext context ,String? value, String? confirmValue) {
    final passwordValidator =
        Validate.validatePassword( context ,value, confirmPassword: confirmValue);
    if (passwordValidator == null) {
      return null;
    } else {
      return passwordValidator;
    }
  }

  static String? emailValidate(BuildContext context , String? value) {
    final emailValidator = Validate.validateEmail( context ,value);
    if (emailValidator == null) {
      return null;
    } else {
      return emailValidator;
    }
  }

  static String? phoneValidate(BuildContext context ,String? value) {

    var locale = AppLocalizations.of(context);
    final phoneValidator = Validate.validatePhoneNumber( context ,value);
    if (phoneValidator == null) {
      final regex = RegExp(r'^(009665|9665|\+9665|05|5)(5|0|3|6|4|9|1|8|7)([0-9]{7})$');

      if (value != null && !regex.hasMatch(value)) {
        return locale!.isDirectionRTL(context) ? "الرجاء إدخال رقم هاتف صالح" : "Please Enter a valid phone number";
      }
      return null;
    } else {
      return phoneValidator;
    }
  }

  static String? nameValidate(BuildContext context ,String? value) {
    final nameValidator = Validate.validateName( context ,value);
    if (nameValidator == null) {
      return null;
    } else {
      return nameValidator;
    }
  }
  static String? numValidate(BuildContext context ,String? value) {
    final numberValidator = Validate.validatePhoneNumber( context ,value);
    if (numberValidator == null) {
      return null;
    } else {
      return numberValidator;
    }
  }

  static String? creditValidate(BuildContext context ,String? value) {
    final validator = Validate.validateCreditCardNumber( context ,value);
    if (validator == null) {
      return null;
    } else {
      return validator;
    }
  }

  static String? cvvValidate(BuildContext context ,String? value) {
    final validator = Validate.validateCVV( context ,value);
    if (validator == null) {
      return null;
    } else {
      return validator;
    }
  }

  static String? dateValidate(String? value) {
    final validator = Validate.validateDate(value);
    if (validator == null) {
      return null;
    } else {
      return validator;
    }
  }
}
