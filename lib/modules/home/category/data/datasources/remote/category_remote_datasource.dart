import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/category/data/models/category_model.dart';
import 'package:dio/dio.dart';

class CategoryRemotDataSource {
  static Dio? _dio = Dio();
  Future<CategoryModelData> getCategory() async {
    try {
      final Response response = await _dio!.get(
        mainApi + category,
        options: Options(responseType: ResponseType.plain, headers: {
          "Accept": "application/json",
          "Accept-Language": langCode == '' ? "en" : langCode
        }),
      );
      final list = json.decode(response.data);
      CategoryModelData categoryModelData = CategoryModelData.fromJson(list);

      return categoryModelData;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
