import 'dart:convert';
import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/modules/home/profile/data/models/delete_profile_model.dart';
import 'package:http/http.dart' as http;

class DeleteProfileService {
  static Future<DeleteProfileModel> deleteProfile(String? languageCode) async {
    try {
      final SharedPreferencesHelper preferences = SharedPreferencesHelper();
      final token = await preferences.getToken();
      var response = await http.post(Uri.parse(mainApi + '/deleteAccount'), headers: {
        "Accept": "application/json",
        "Authorization": "Bearer $token",
        'Accept-Language': langCode == "" ? 'en' : langCode
      });
      print(response.body);
      var data = json.decode(response.body) as Map<String, dynamic>;
      if (response.statusCode == 200) {
        return DeleteProfileModel.fromJson(data);
      } else if (response.statusCode == 500) {
        throw Exception("Server Error");
      } else if (response.statusCode == 401) {
        throw Exception("Not Authenticated");
      } else if (response.statusCode == 422) {
        throw Exception("Data is not valid");
      } else if (response.statusCode == 404) {
        throw Exception("Data Not Found");
      } else if (response.statusCode == 429) {
        throw Exception("Too many requests");
      } else if (response.statusCode == 403) {
        throw Exception("Your Request Is Not Allowed");
      } else {
        throw Exception();
      }
    } catch (error) {
      throw Exception(error);
    }
  }
}
