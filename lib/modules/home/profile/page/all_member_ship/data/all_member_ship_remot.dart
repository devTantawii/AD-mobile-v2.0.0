import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/profile/page/all_member_ship/model/all_member_model.dart';
import 'package:dio/dio.dart';

class AllMemberShipRemoteDataSource {
  final Dio _dio = Dio();

  Future<AllMember> getAllMemberShip() async {
    try {
      final Response response = await _dio.get(
        allMemberShip,
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            "Accept": "application/json",
            "Accept-Language": langCode == "" ? "en" : langCode
          },
        ),
      );
      final dataMemberShip = json.decode(response.data);
      final AllMember memberShip = AllMember.fromMap(dataMemberShip);
      return memberShip;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }
}
