import 'dart:convert';

import 'package:abudiyab/modules/home/additions/data/models/automated_step_one_order_model.dart';

AutomatedInvoiceModel automatedInvoiceModelFromJson(String str) =>
    AutomatedInvoiceModel.fromJson(json.decode(str));

String automatedInvoiceModelToJson(AutomatedInvoiceModel data) =>
    json.encode(data.toJson());

class AutomatedInvoiceModel {
  AutomatedInvoiceModel({
    this.features,
    this.tax,
    this.authorizationFee,
    this.diff,
    this.contract,
  });

  int? diff;
  double? tax;
  int? features;
  Contract? contract;
  int? authorizationFee;

  factory AutomatedInvoiceModel.fromJson(Map<String, dynamic> json) =>
      AutomatedInvoiceModel(
        diff: json["diff"],
        features: json["features"],
        tax: json["tax"]?.toDouble(),
        authorizationFee: json["authorization_fee"],
        contract: Contract.fromJson(json["contract"]),
      );

  Map<String, dynamic> toJson() => {
        "tax": tax,
        "diff": diff,
        "features": features,
        "contract": contract?.toJson(),
        "authorization_fee": authorizationFee,
      };
}
