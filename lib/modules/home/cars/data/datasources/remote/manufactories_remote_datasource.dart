import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/cars/data/models/manufactories_Model.dart';
import 'package:dio/dio.dart';

class ManufactoriesRemoteDataSource {
  final Dio _dio = Dio();

  Future<Manufactories> getManufactories() async {
    try {
      final Response response = await _dio.get(
        newManufactories,
        options: Options(responseType: ResponseType.plain, headers: {
          "Accept": "application/json",
          "Accept-Language": langCode == '' ? "en" : langCode
        }),
      );
      final manuData = manufactoriesFromMap(response.data);
      return manuData;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
