import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/booking_from_cars/model/branch_from_cars_model.dart';
import 'package:dio/dio.dart';

class BookingFromCarsRemoteDataSource {
  Dio dio = Dio();
  Future<BranchFromCarModel> getBranches({required int carId}) async {
    try {
      final Response response = await dio.get(
        mainApi + '/available/branches/$carId',
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            "Accept": "application/json",
            "Accept-Language": langCode == "" ? "en" : langCode
          },
        ),
      );
      final dataBranch = json.decode(response.data);
      final BranchFromCarModel branchModel =
          BranchFromCarModel.fromMap(dataBranch);
      return branchModel;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
