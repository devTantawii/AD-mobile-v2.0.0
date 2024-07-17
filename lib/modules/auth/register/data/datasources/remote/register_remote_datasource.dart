import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/preferences_constants.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:http/http.dart' as http;

class RegisterRemoteDatasource {
  Future<void> signup(Map<String, String> data, path) async {
    var item = http.MultipartRequest("POST", Uri.parse(mainApi + '/register'));

    item.files.add(
      await http.MultipartFile.fromPath(
        "licenceFace",
        path,
      ),
    );
    item.headers.addAll({"Accept": "application/json", 'Content-type': 'application/json'});

    item.fields.addAll(data);

    var responce = await item.send();
    var responseByteArray = await responce.stream.toBytes();

    if (responce.statusCode == 201) {
      String ut = utf8.decode(responseByteArray);
      var e = json.decode(ut);
      SharedPreferencesHelper sharedPreferences = SharedPreferencesHelper();
      sharedPreferences.set(PreferencesConstants.token, e['token']);

      return Future.value();
    } else {
      String ut = utf8.decode(responseByteArray);
      var e = json.decode(ut);


      throw Exception(e.toString());
    }
  }
}
