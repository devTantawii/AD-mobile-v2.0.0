import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/search_screen/data/models/regions_model.dart';
import 'package:dio/dio.dart';

class RegionsRemoteDatasource {
  final Dio _dio;

  RegionsRemoteDatasource(this._dio);

  Future<List<RegionModel>?> getRegions() async {
    try {
      final Response response = await _dio.get(regions,
          options: Options(
            headers: {
              "Content-Type": "application/json",
              "Accept-Language": langCode == '' ? "en" : langCode
            },
          ));
      final regionsModel = regionModelFromJson(response.data["data"]as List);
      return regionsModel;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
