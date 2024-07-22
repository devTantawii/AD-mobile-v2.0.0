import 'dart:convert';


import '../../../all_bookings/data/model/featuresModel.dart';

AutomatedStepOneOrderModel automatedStepOneOrderModelFromJson(String str) =>
    AutomatedStepOneOrderModel.fromJson(json.decode(str));

String automatedStepOneOrderModelToJson(AutomatedStepOneOrderModel data) =>
    json.encode(data.toJson());

class AutomatedStepOneOrderModel {
  AutomatedStepOneOrderModel({
    this.status,
    this.diff,
    this.contract,
    this.features,
  });

  bool? status;
  int? diff;
  Contract? contract;
  List<FeatureNotCompletedModel>? features;

  factory AutomatedStepOneOrderModel.fromJson(Map<String, dynamic> json) =>
      AutomatedStepOneOrderModel(
        contract: Contract.fromJson(json["contract"]),
        diff: double.parse(json["diff"].toString()).toInt(),
        status: json["status"],
        features: List<FeatureNotCompletedModel>.from(json["features"]?.map((x) => FeatureNotCompletedModel.fromMap(x)) ?? []),
      );

  Map<String, dynamic> toJson() => {
        "diff": diff,
        "status": status,
        "contract": contract?.toJson(),
        "features": List<FeatureNotCompletedModel>.from(features?.map((x) => x) ?? []),
      };
}

class Contract {
  Contract({
    this.id,
    this.contractNo,
    this.contractType,
    this.kiloReadIn,
    this.carPrice,
    this.recievingLocationId,
    this.deliveryLocationId,
    this.deliveryDate,
    this.recivingDate,
    this.extraKmPrice,
    this.extraDayPrice,
    this.extraHourPrice,
    this.total,
    this.status,
  });

  int? id;
  String? contractNo;
  String? contractType;
  dynamic kiloReadIn;
  dynamic carPrice;
  String? recievingLocationId;
  String? deliveryLocationId;
  DateTime? deliveryDate;
  DateTime? recivingDate;
  int? extraKmPrice;
  dynamic extraDayPrice;
  double? extraHourPrice;
  dynamic total;
  String? status;

  factory Contract.fromJson(Map<String, dynamic> json) => Contract(
        id: json["id"],
        total: json["total"],
        status: json["status"],
        carPrice: json["car_price"],
        contractNo: json["contract_no"],
        kiloReadIn: json["kilo_read_in"],
        contractType: json["contract_type"].toString(),
        extraKmPrice: json["extra_km_price"],
        extraDayPrice: json["extra_day_price"],
        deliveryLocationId: json["delivery_location_id"],
        recievingLocationId: json["recieving_location_id"],
        deliveryDate: DateTime.parse(json["delivery_date"]),
        extraHourPrice: json["extra_hour_price"].toDouble(),
        recivingDate: DateTime.parse(json["reciving_date"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "contract_no": contractNo,
        "contract_type": contractType,
        "kilo_read_in": kiloReadIn,
        "car_price": carPrice,
        "recieving_location_id": recievingLocationId,
        "delivery_location_id": deliveryLocationId,
        "delivery_date": deliveryDate?.toIso8601String(),
        "reciving_date": recivingDate?.toIso8601String(),
        "extra_km_price": extraKmPrice,
        "extra_day_price": extraDayPrice,
        "extra_hour_price": extraHourPrice,
        "total": total,
        "status": status,
      };
}
