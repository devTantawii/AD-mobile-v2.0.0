import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:http/http.dart' as http;

class BranchesService {
  static Future<List<BranchModel>> getBranches(
      {String languageCode = 'en', int pageIndex = 1, int? regionId}) async {
    var response = await http.get(
      Uri.parse(mainApi + '/branches?page=$pageIndex' + '&regions=$regionId'),
      headers: {
        "Content-Type": "application/json",
        "Accept-Language": langCode == '' ? "en" : langCode
      },
    );
    if (response.statusCode == 200) {
      var data = json.decode(response.body) as Map<String, dynamic>;
      List list = data['data'] as List;
      List<BranchModel> list2 = [];
      print(list);
      for (var item in list) {
        list2.add(BranchModel.fromMap(item));
      }

      print(list2);
      return list2;
    } else {
      print(response.statusCode);
      throw Exception(response.body);
    }
  }
}
