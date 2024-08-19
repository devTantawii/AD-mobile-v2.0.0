import 'package:abudiyab/core/helpers/SharedPreference/pereferences.dart';
import 'package:abudiyab/modules/home/additions/data/datasource/remote/order_addition_remote_datasource.dart';
import 'package:abudiyab/modules/home/additions/data/models/automated_step_one_order_model.dart';
import 'package:abudiyab/modules/home/additions/data/models/step_one_order_model.dart';

import '../../../../../core/helpers/helper/date_helper.dart';


class AdditionRepository {
  final SharedPreferencesHelper preferences;
  final OrderAdditionsRemoteDatasource orderAdditionsRemoteDatasource;

  AdditionRepository(this.orderAdditionsRemoteDatasource, this.preferences);
  Future<StepOneOrderModel?> getCarOrder({
    String? languageCode,
    required String carId,
    required String receiveBranchId,
    required String driveBranchId,
    required DateTime receiveDate,
    required DateTime driveDate,
    required String receiveTimeValue,
    required String driveTimeValue,
  }) async {
    receiveTimeValue
        .toString()
        .replaceAll("TimeOfDay", "")
        .replaceAll("(", "")
        .replaceAll(")", "");
    String deliveryHour = driveTimeValue
        .toString()
        .replaceAll("TimeOfDay", "")
        .replaceAll("(", "")
        .replaceAll(")", "");
    return await orderAdditionsRemoteDatasource.getCarOrder(
      token: await preferences.getToken() ?? "",
      languageCode: languageCode,
      carId: carId,
      receiveBranchId: receiveBranchId,
      driveBranchId: driveBranchId,
      receiveDate: receiveDate.toString(),
      // receiveDate: receiveDate,
      // driveDate: driveDate,
      driveDate: driveDate.toString(),
    );

  }

  Future<AutomatedStepOneOrderModel?> getAutomatedCarOrder({
    String? languageCode,
    required String carId,
    required String receiveLocationId,
    required String driveLocationId,
    required DateTime receiveDate,
    required DateTime driveDate,
    required String receiveTimeValue,
    required String driveTimeValue,
  }) async {
    print(driveTimeValue);
    String receiveHour = receiveTimeValue
        .toString()
        .replaceAll("TimeOfDay", "")
        .replaceAll("(", "")
        .replaceAll(")", "");
    String deliveryHour = driveTimeValue
        .toString()
        .replaceAll("TimeOfDay", "")
        .replaceAll("(", "")
        .replaceAll(")", "");
    return await orderAdditionsRemoteDatasource.getAutomatedCarOrder(
      token: await preferences.getToken() ?? "",
      carId: carId,
      languageCode: languageCode,
      driveLocationId: driveLocationId,
      receiveLocationId: receiveLocationId,
      driveDate: DateHandler.mixDateWithHours(driveDate, deliveryHour),
      receiveDate: DateHandler.mixDateWithHours(receiveDate, receiveHour),
    );
  }


}
