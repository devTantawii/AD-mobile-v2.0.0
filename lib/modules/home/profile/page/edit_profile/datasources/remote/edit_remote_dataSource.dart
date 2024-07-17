import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class EditProfileDataSource {
  Future<void> editProfile(
      {required String image,required String licenceImage, required Map<String, String> data}) async {
    try {
      var item = http.MultipartRequest("POST", Uri.parse(mainApi + '/profile'));

      if (image != "") {
        item.files.add(
          await http.MultipartFile.fromPath(
            "avatar",
            image,
          ),
        );
      }
      if (licenceImage != "") {
        print("545454");
        item.files.add(
          await http.MultipartFile.fromPath(
            "licenceFace",
            licenceImage,
          ),
        );
      }
      SharedPreferences sharedPreferences =
          await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString('TOKEN');
      item.headers.addAll({
        "Accept": "application/json",
        'Content-type': 'application/json',
        'Authorization': "Bearer $token",
        "Accept-Language": langCode == '' ? "en" : langCode
      });
      item.fields.addAll(data);
      var response = await item.send();
      if (response.statusCode == 200) {
      } else {
        throw Exception("The given data was invalid.");
      }
    } catch (e) {
      throw Exception(e);
    }
  }
}
