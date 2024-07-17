// To parse this JSON data, do
//
//     final couponModel = couponModelFromJson(jsonString);

import 'dart:convert';

CouponModel couponModelFromJson(String str) =>
    CouponModel.fromJson(json.decode(str));

// String couponModelToJson(CouponModel data) => json.encode(data.toJson());

class CouponModel {
  CouponModel({
    this.price,
    this.finalPrice,
    this.discount,
    this.message,
  });

  double? price;
  double? finalPrice;
  int? discount;
  String? message;

  factory CouponModel.fromJson(Map<String, dynamic> json) => CouponModel(
        price: json["price"]?.toDouble() ?? 0.0,
        finalPrice: json["final_price"]?.toDouble() ?? 0.0,
        discount: json["discount"] ??0,
        message: json["message"] ,
      );
}
