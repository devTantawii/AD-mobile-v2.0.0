import 'dart:convert';

import 'package:abudiyab/core/constants/api_path.dart';
import 'package:abudiyab/core/constants/langCode.dart';
import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/core/helpers/exception/exceptions.dart';
import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';
import 'package:dio/dio.dart';

class CarsRemoteDataSource {
  final Dio _dio;
  final SharedPreferencesHelper sharedPreferencesHelper;

  CarsRemoteDataSource(this._dio, this.sharedPreferencesHelper);

  Future<Cars> getAllCars(
    int pageNumber, {
    int? branchId,
    String? castClass,
    List<String>? categoryIds,
    List<String>? manufactoryIds,
    int? minPrice,
    int? maxPrice,
    int? model,
    // int? availableOnly,
  }) async {
    try {
      // final String? catIds =
      // _generateCategorySearchParameters(categoryIds ?? []);
      // final String? brandIds =
      // _generateBrandSearchParameters(manufactoryIds ?? []);
      final token = await sharedPreferencesHelper.getToken();
      final Response response = await _dio.get(
        branchId == null
            ? mainApi + allCars + "?page=$pageNumber&cust_class=$castClass"
            : mainApi + carsByBranch + "$branchId" + carsByPages2 + "$pageNumber" + custClass + "$castClass",
        //   queryParameters: {
        //   if (availableOnly != "null" && availableOnly!) 'available': 1,
        // },
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            "Accept": "application/json",
            "Authorization": "Bearer $token",
            "Accept-Language": langCode == "" ? "en" : langCode
          },
        ),
      );
      final dataCars = json.decode(response.data) as Map<String, dynamic>;
      final Cars cars = Cars.fromMap(dataCars);
      if (response.statusCode == 200) {
      } else {}

      return cars;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }

  ///*******************************filters----------------------
  Future<Cars> getCarsByFilter({
    required int pageNumber,
    // int? branchId,
    String? customerClass,
    List<String>? categoryIds,
    List<String>? manufactoryIds,
    List<String>? model,
    int? minPrice,
    int? maxPrice,
  }) async {
    try {
      // final token = await sharedPreferencesHelper.getToken();
      final String? catIds = _generateCategorySearchParameters(categoryIds ?? []);
      final String? brandIds = _generateBrandSearchParameters(manufactoryIds ?? []);
      final String? modelYears = _generateModelSearchParameters(model ?? []);

      // print('Ashraf' + brandIds.toString());
      final Response response = await _dio.get(
        mainApi +
            allCars +
            "?$catIds&$brandIds&$modelYears&minimum=$minPrice&maximum=$maxPrice&page=$pageNumber&cust_class=$customerClass",
        options: Options(
          responseType: ResponseType.plain,
          headers: {
            "Accept": "application/json",
            //"Authorization": "Bearer $token",
            "Accept-Language": langCode == "" ? "en" : langCode
          },
        ),
      );
      final dataCars = json.decode(response.data) as Map<String, dynamic>;
      final Cars cars = Cars.fromMap(dataCars);
      return cars;
    } on DioError catch (dioError) {
      throw Failure.fromDioError(dioError);
    } catch (error) {
      throw '..Oops $error';
    }
  }

  String _generateCategorySearchParameters(List<String> categoryIds) {
    if (categoryIds.isNotEmpty) {
      final cats = categoryIds.map((e) => "category_ids[]=$e&").toList();
      cats.last = cats.last.substring(0, cats.last.length - 1);
      var catsData = cats.toString().replaceFirst("[", "");
      catsData = catsData
          .toString()
          .substring(0, catsData.length - 1)
          .replaceAll(" ", "")
          .replaceAll(",", "");
      return catsData.toString();
    }
    return "";
  }

  String? _generateBrandSearchParameters(List<String> brandIds) {
    if (brandIds.isNotEmpty) {
      final brands = brandIds.map((e) => "manufactory_ids[]=$e&").toList();
      brands.last = brands.last.substring(0, brands.last.length - 1);
      var brandData = brands.toString().replaceFirst("[", "");
      brandData = brandData
          .toString()
          .substring(0, brandData.length - 1)
          .replaceAll(" ", "")
          .replaceAll(",", "");
      // print ("Hammad" +  brandData.toString());
      return brandData;
    }
    return "";
  }

  ///--------------------------------
  String _generateModelSearchParameters(List<String> modelYears) {
    if (modelYears.isNotEmpty) {
      final cats = modelYears.map((e) => "model_years[]=$e&").toList();
      cats.last = cats.last.substring(0, cats.last.length - 1);
      var catsData = cats.toString().replaceFirst("[", "");
      catsData = catsData
          .toString()
          .substring(0, catsData.length - 1)
          .replaceAll(" ", "")
          .replaceAll(",", "");
      return catsData.toString();
    }
    return "";
  }
}
