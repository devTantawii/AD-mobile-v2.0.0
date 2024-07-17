import 'dart:convert';
import 'dart:developer';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/all_branching/data/models/branch_model.dart';
import 'package:dio/dio.dart';

class AllBranchRemoteDataSource {
  final Dio dio = Dio();

  Future<Data> getBranches(
      {String languageCode = 'en', int pageIndex = 1, int? regionId}) async {
    try {
      final Response response = await dio.get(
        mainApi + '/branches?page=$pageIndex',
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            "Accept": "application/json",
            "Accept-Language": langCode == "" ? "en" : langCode
          },
        ),
      );
      final dataBranch = json.decode(response.data);
      log(dataBranch.toString());
      final Data branchModel = Data.fromMap(dataBranch);
      return branchModel;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
