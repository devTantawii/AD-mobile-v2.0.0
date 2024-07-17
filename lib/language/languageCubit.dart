import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/constants/preferences_constants.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LanguageCubit extends Cubit<Locale> {
  final SharedPreferencesHelper sharedPreferencesHelper;
  LanguageCubit(this.sharedPreferencesHelper) : super(Locale('ar')) {
    emitLocale();
  }

  emitLocale() async {
    langCode = await sharedPreferencesHelper.get(PreferencesConstants.lang) ?? "ar";
    emit(Locale(await sharedPreferencesHelper.get(PreferencesConstants.lang) ?? "ar"));
  }

  void selectEngLanguage() async {
    await sharedPreferencesHelper.set(PreferencesConstants.lang, "en");
    langCode = 'en';
    emit(Locale('en'));
  }

  void selectArabicLanguage() async {
    await sharedPreferencesHelper.set(PreferencesConstants.lang, "ar");
    langCode = 'ar';
    emit(Locale('ar'));
  }

}
