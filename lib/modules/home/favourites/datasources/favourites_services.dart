import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/modules/home/favourites/models/favourites.dart';
import 'package:http/http.dart' as http;

class FavouritesService {
  static Future<List<Favorite>> getFavourites({String? languageCode}) async {
    final SharedPreferencesHelper preferences = SharedPreferencesHelper();
    final token = await preferences.getToken();
    var responce = await http.get(Uri.parse(mainApi + '/profile'), headers: {
      "Accept": "application/json",
      "Authorization": "Bearer $token",
      'x-accept-language': langCode == "" ? 'en' : langCode
    });
    var data = json.decode(responce.body) as Map<String, dynamic>;

    if (responce.statusCode == 200) {
      final favouriteData = data['data']['favorite'] as List;
      final List<Favorite> favourites = <Favorite>[];
      favouriteData.forEach((element) {
        favourites.add(Favorite.fromMap(element));
      });
      return favourites;
      // return data.;
    } else if (responce.statusCode == 401) {
      throw Exception(data['message']);
    } else {
      return throw Exception();
    }
  }
}
