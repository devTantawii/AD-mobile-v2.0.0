///Base class if you want to create your own shared preferences implementations.
///
///See Also:
///* `SharedPreferencesStorePlatform`
abstract class BaseSharedPreferences {
  Future<bool> setString(String key, String value);

  ///Saves a boolean [value] to persistent storage in the background.
  Future<bool> setBool(String key, bool value);

  ///Saves a double [value] to persistent storage in the background.
  ///
  ///Android doesn't support storing doubles, so it will be stored as a float.
  Future<bool> setDouble(String key, double value);

  ///Saves an integer [value] to persistent storage in the background.
  Future<bool> setInt(String key, int value);

  ///Reads a value of any type from persistent storage.
  Object? get(String key);

  ///Removes an entry from persistent storage.
  Future<bool> remove(String key);

  ///Completes with true once the user preferences for the app has been cleared.
  Future<bool> clear();

  ///Check the key is saved or not.
  bool containsKey(String key);

  ///Checkes wheather the storage is empty or not.
  ///
  ///See also:
  ///* `SharedPreferences.getKeys()`
  bool isEmpty();
}
