import 'package:abudiyab/core/constants/preferences_constants.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/modules/auth/signin/data/models/user_data_model.dart';

abstract class SignInLocalDataSource {
  saveUserData(UserData userData);

  getUserData();

  saveToken(String token);

  getToken();
}

class SignInLocalDataSourceImpl extends SignInLocalDataSource {
  final SharedPreferencesHelper preferences;

  SignInLocalDataSourceImpl( this.preferences);

  @override
  saveUserData(UserData userData) async => await preferences.set(PreferencesConstants.userData, userData.toString());

  @override
  getUserData() async => UserData.fromJson(preferences.get(PreferencesConstants.userData) as Map<String , dynamic>);

  @override
  saveToken(String token) async => await preferences.set(PreferencesConstants.token, token);

  @override
  getToken() async =>  preferences.get(PreferencesConstants.token);
}
