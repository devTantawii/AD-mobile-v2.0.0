import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/slider_model.dart';
import 'package:dio/dio.dart';

class HeadlinesRemoteDataSource {
  final Dio dio = Dio();
  Future<SliderModel> getSlider() async {
    try {
      final Response response = await dio.get(
        sliderData,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            "Accept": "application/json",
            "Accept-Language": langCode == "" ? "en" : langCode
          },
        ),
      );
      final dataSlider = json.decode(response.data);
      final SliderModel sliderModel = SliderModel.fromMap(dataSlider);
      return sliderModel;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
