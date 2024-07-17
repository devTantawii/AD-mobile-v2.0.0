import 'package:abudiyab/core/constants/preferences_constants.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';

abstract class RegisterLocalDataSource {
  saveToken(String token);

  getToken();
}

class RegisterLocalDataSourceImpl extends RegisterLocalDataSource {
  final SharedPreferencesHelper preferences;

  RegisterLocalDataSourceImpl( this.preferences);

  @override
  saveToken(String token) async =>
      await preferences.set(PreferencesConstants.token, token);

  @override
  getToken() async => preferences.get(PreferencesConstants.token);
}
