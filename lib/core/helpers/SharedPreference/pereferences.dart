import 'dart:developer';

import 'package:abudiyab/core/constants/preferences_constants.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'base_shared_preferences.dart';

export 'base_shared_preferences.dart';

class SharedPreferencesHelper {
  static SharedPreferences? sP;
  static init() async {
    sP = await SharedPreferences.getInstance();
  }

  Future<bool> set(String key, String value) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setString(key, value);
  }

  Future<String?>? get(String key) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getString(key);
  }

  Future<String?> getToken() async => await get(PreferencesConstants.token);
  static dynamic getDataFromSP({required String key}) {
    return sP!.get(PreferencesConstants.lang);
  }
  // String? getLang() => sp.get(PreferencesConstants.lang).toString();

  Future<String?> getUserID() async => get(PreferencesConstants.userData);

  Future<void> clear(String s) async {
    final SharedPreferences preferences = await SharedPreferences.getInstance();
    preferences.clear();
  }
}

///Acts as a wrapper for [SharedPreferences] to make saving and getting saved value as easy as possible
///in addition of adding more cool feature like removing multiple values at once.
///
class PreferenceUtils {
  PreferenceUtils._();

  static late BaseSharedPreferences? _preferences;
  static PreferenceUtils _instance = PreferenceUtils._();

  //Returns an instance of the class to interface with.
  static PreferenceUtils get instance {
    return _instance;
  }

  /// init the class in `main` function
  static Future<BaseSharedPreferences> init() async {
    if (_preferences == null) {
      _preferences = await _ProductionSharedPreferences.getInstance();
      log("Shared Preferences has been initiated");
    }
    return _preferences!;
  }

  ///Initialize the [PreferenceUtils] using mock [BaseSharedPreferences] implementation to test.
  @visibleForTesting
  static Future<void> initWithMock(BaseSharedPreferences preferences) async {
    _preferences = preferences;
    log("MOCK Shared Preferences has been initiated");
  }

  ///Returns true if the class has been initialized with BaseSharedPreferences] implementation.
  @visibleForTesting
  Null get initialized => _preferences = null;

  bool containsKey(String key) {
    return _preferences!.containsKey(key);
  }

  /// `T` is the  `runTimeType` data which you are trying to save (`bool` - `String` - `double`)
  Future<bool> saveValueWithKey<T>(String key, T value,
      {bool hideDebugPrint = false}) async {
    if (hideDebugPrint)
      log("SharedPreferences: [Saving data] -> key: $key, value: $value");
    _preferencesAssertion();
    if (value is String) {
      return await _preferences!.setString(key, value);
    } else if (value is bool) {
      return await _preferences!.setBool(key, value);
    } else if (value is double) {
      return await _preferences!.setDouble(key, value);
    } else if (value is int) {
      return await _preferences!.setInt(key, value);
    }
    throw NotSupportedTypeToSaveException();
  }

  ///Get a saved value using given `Key`.
  ///
  ///if value does not exist returns `null`.
  E getValueWithKey<E>(String key, {bool hideDebugPrint = false}) {
    _preferencesAssertion();
    var value = _preferences!.get(key);
    if (hideDebugPrint)
      log("SharedPreferences: [Reading data] -> key: $key, value: $value");
    return value as E;
  }

  ///Remove saved value with `Key` form local DB.
  Future<bool> removeValueWithKey(String key) async {
    _preferencesAssertion();
    var value = _preferences!.get(key);
    if (value == null) return true;
    log("SharedPreferences: [Removing data] -> key: $key, value: $value");
    return await _preferences!.remove(key);
  }

  ///Remove saved values with `Keys` form local DB.
  Future<void> removeMultipleValuesWithKeys(List<String> keys) async {
    _preferencesAssertion();
    var value;
    for (String key in keys) {
      value = _preferences!.get(key);
      if (value == null) {
        log("SharedPreferences: [Removing data] -> key: $key, value: {ERROR 'null' value}");
        log("Skipping...");
      } else {
        await _preferences!.remove(key);
        log("SharedPreferences: [Removing data] -> key: $key, value: $value");
      }
    }
    return;
  }

  ///Clear all app saved preferences.
  Future<bool> clearAll() async {
    _preferencesAssertion();
    return await _preferences!.clear();
  }

  ///Returns `true` if the local storage is empty.
  @visibleForTesting
  bool isEmpty() {
    _preferencesAssertion();
    return _preferences!.isEmpty();
  }

  void _preferencesAssertion() {
    if (_preferences == null) {
      throw PreferenceUtilsNotInitializedException("_preferences == null");
    }
  }
}

///Production wrapper for [SharedPreferences].
class _ProductionSharedPreferences extends BaseSharedPreferences {
  _ProductionSharedPreferences._();

  static late SharedPreferences _sharedPreferences;

  static late _ProductionSharedPreferences? _instance;

  ///Loads and parses the [SharedPreferences] for this app from disk.
  static Future<_ProductionSharedPreferences?> getInstance() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (_instance == null) {
      _instance = _ProductionSharedPreferences._();
    }
    return _instance;
  }

  ///Completes with true once the user preferences for the app has been cleared.
  @override
  Future<bool> clear() {
    return _sharedPreferences.clear();
  }

  ///Reads a value of any type from persistent storage.
  @override
  Object? get(String key) {
    return _sharedPreferences.get(key);
  }

  ///Removes an entry from persistent storage.
  @override
  Future<bool> remove(String key) {
    return _sharedPreferences.remove(key);
  }

  ///Saves a boolean [value] to persistent storage in the background.
  @override
  Future<bool> setBool(String key, bool value) {
    return _sharedPreferences.setBool(key, value);
  }

  ///Saves a double [value] to persistent storage in the background.
  ///
  ///Android doesn't support storing doubles, so it will be stored as a float.
  @override
  Future<bool> setDouble(String key, double value) {
    return _sharedPreferences.setDouble(key, value);
  }

  ///Saves an integer [value] to persistent storage in the background.
  @override
  Future<bool> setInt(String key, int value) {
    return _sharedPreferences.setInt(key, value);
  }

  ///Saves a string [value] to persistent storage in the background.
  @override
  Future<bool> setString(String key, String value) {
    return _sharedPreferences.setString(key, value);
  }

  ///Checked whether the storage is empty or not.
  ///
  ///See also:
  ///* `SharedPreferences.getKeys()`
  @override
  bool isEmpty() {
    return _sharedPreferences.getKeys().isEmpty;
  }

  @override
  bool containsKey(key) {
    return _sharedPreferences.containsKey(key);
  }
}
