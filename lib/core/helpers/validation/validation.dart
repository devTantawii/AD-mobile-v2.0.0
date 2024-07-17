import 'package:abudiyab/language/locale.dart';
import 'package:flutter/cupertino.dart';

class Validate {
  static String? validateName(BuildContext context , String? value) {
    final locale = AppLocalizations.of(context);

    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return locale!.pleaseEnterName;
    }

    if (value.length < 4) {
      return locale!.enterNameMiniChars;
    }
    return null;
  }

  static String? validateEmail(BuildContext context , String? value, {String? error}) {
    final locale = AppLocalizations.of(context);

    if (value == null) return null;
    if (value.isEmpty) {
      return locale!.pleaseEnterEmail;
    }
    Pattern pattern =
        r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
    RegExp regex = new RegExp(pattern.toString());
    if (!regex.hasMatch(value)) return locale!.enterValidEmail;

    if (error != null) return error;

    return null;
  }

  static String? validateSelectCountry(String? value) {
    // final locale = AppLocalizations.of(context);

    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return 'Please select country';
    }
    return null;
  }

  static String? validatePhoneNumber(BuildContext context , String? value) {
    final locale = AppLocalizations.of(context);

    if (value == null) {
      return null;
    }
    if (value.isEmpty) {
      return locale!.pleaseEnterPhoneNumber;
    }
    // if (value.length == 8) {
    //    FocusScope.of(context).unfocus();
    // }
    if (value.length < 8) {
      return locale!.pleaseEnterNumberMinimum;
    }
    return null;
  }

  static String? validatePassword(BuildContext context , String? value, {String? confirmPassword}) {
    final locale = AppLocalizations.of(context);
    if (value == null) {
      return null;
    }
    if (confirmPassword != null && value != confirmPassword) {
      return locale!.passwordNotMatching;
    }
    if (value.isEmpty) {
      return locale!.pleaseEnterPassword;
    }
    return null;
  }

  static String? validateCreditCardNumber(BuildContext context , String? value) {
    final locale = AppLocalizations.of(context);
    if (value == null) return null;
    if (value.isEmpty) return locale!.pleaseEnterValidCredit;
    // final pattern = RegExp(r"\s+");
    // if (!pattern.hasMatch(value)) return "Please enter valid credit";
    return null;
  }
  static String? validateCVV(BuildContext context , String? value) {
    final locale = AppLocalizations.of(context);

    if (value == null) return null;
    if (value.isEmpty) return locale!.enterValidCVV;
    return null;
  }

  static String? validateDate(String? value) {
    if (value == null) return null;
    if (value.isEmpty) return " ";
    if (value.length < 2) return " ";
    return null;
  }
}
