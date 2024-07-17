import 'dart:convert';

import 'package:abudiyab/modules/home/cars/data/models/cars_model.dart';

Booking bookingFromMap(String str) =>
    Booking.fromMap(json.decode(str) as Map<String, dynamic>);

String bookingToMap(Booking data) => json.encode(data.toMap());

class Booking {
  Booking({
    required this.data,
  });
  List<Datum?>? data;
  factory Booking.fromMap(Map<String, dynamic> json) => Booking(
        data: List<Datum>.from(json["data"]?.map((x) => Datum.fromMap(x)) ?? []),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data?.map((x) => x?.toMap()) ?? []),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.car,
    required this.recivingBranch,
    required this.deliveryBranch,
    required this.receivingDateWithTime,
    required this.deliveryDateWithTime,
    required this.receive_date,
    required this.deliver_date,
    required this.receive_time,
    required this.deliver_time,
    required this.paymentType,
    required this.paymentStatus,
    required this.price,
    required this.featuresAdded,
    required this.createdAt,
    required this.status,
    required this.visaAmout,
    required this.statusText,
    required this.paymentStatment,
    required this.canCancel,
    required this.step,
    ///
     required this.rent_price,
     required this.additions,
     required this.tamm_price,
     required this.total,
     required this.net_price,
     required this.vat_value,
     required this.general_total,
     required this.membership_discount,
     required this.promotional_discount,
  });

  int id;
  DataCars car;
  RecivingBranch recivingBranch;
  DeliveryBranch deliveryBranch;
  dynamic receivingDateWithTime;
  String? deliveryDateWithTime;
  String? receive_date;
  String? deliver_date;
  String? receive_time;
  String? deliver_time;
  String? paymentType;
  String? paymentStatus;
  dynamic rent_price;
  dynamic additions;
  dynamic tamm_price;
  dynamic total;
  dynamic net_price;
  dynamic vat_value;
  dynamic membership_discount;
  dynamic promotional_discount;
  dynamic general_total;
  double price;
  List<dynamic>? featuresAdded;
  String? createdAt;
  String? status;
  String? visaAmout;
  String? statusText;
  String? paymentStatment;
  bool? canCancel;
  dynamic step;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        car: DataCars.fromMap(json["car"]),
        recivingBranch: RecivingBranch.fromMap(json["reciving_branch"]),
        deliveryBranch: DeliveryBranch.fromMap(json["delivery_branch"]),
        receivingDateWithTime: json["reciving_date"],
        deliveryDateWithTime: json["delivery_date"],
        deliver_date: json["deliver_date"],
        deliver_time: json["deliver_time"],
        receive_date: json["receive_date"],
        receive_time: json["receive_time"],
        paymentType: json["payment_type"],
        paymentStatus: json["payment_status"],
        rent_price: json["rent_price"],
         additions: json["additions"],
        membership_discount:json["membership_discount"] ,
        promotional_discount:json["promotional_discount"] ,
        tamm_price:json["tamm_price"],
        total:json["total"],
        net_price:json["net_price"],
        vat_value:json["vat_value"],
    general_total:json["general_total"],
        price: json["price"]?.toDouble() ?? 0.0,
        featuresAdded:
            List<dynamic>.from(json["features_added"]?.map((x) => x) ?? []),
        createdAt: json["created_at"],
        status: json["status"],
        visaAmout: json["visa_amout"],
        statusText: json["status_text"],
        paymentStatment: json["payment_statment"],
        canCancel: json["can_cancel"],
        step: json["step"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "car": car.toMap(),
        "reciving_branch": recivingBranch.toMap(),
        "delivery_branch": deliveryBranch.toMap(),
        "reciving_date": receivingDateWithTime,
        "delivery_date": deliveryDateWithTime,
        "payment_type": paymentType,
        "payment_status": paymentStatus,
        "price": price,
        "features_added": List<dynamic>.from(featuresAdded?.map((x) => x) ??[]),
        "created_at": createdAt,
        "status": status,
        "visa_amout": visaAmout,
        "status_text": statusText,
        "payment_statment": paymentStatment,
        "can_cancel": canCancel,
        "step": step,
      };
}

class DeliveryBranch {
  int? id;
  String? name;
  String? region;
  String? address;

  String? lat;
  String? long;
  String? phone;

  DeliveryBranch({
    required this.id,
    required this.name,
    required this.region,
    required this.address,
    required this.lat,
    required this.long,
    required this.phone,
  });
  factory DeliveryBranch.fromMap(Map<String, dynamic> json) => DeliveryBranch(
        id: json["id"],
        name: json["name"],
        region: json["region"],
        address: json["address"],
        lat: json["lat"],
        long: json["long"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "region": region,
        "address": address,
        "lat": lat,
        "long": long,
        "phone": phone,
      };
}

class RecivingBranch {
  int? id;
  String? name;
  String? region;
  String? address;

  String? lat;
  String? long;
  String? phone;

  RecivingBranch({
    required this.id,
    required this.name,
    required this.region,
    required this.address,
    required this.lat,
    required this.long,
    required this.phone,
  });
  factory RecivingBranch.fromMap(Map<String, dynamic> json) => RecivingBranch(
        id: json["id"],
        name: json["name"],
        region: json["region"],
        address: json["address"],
        lat: json["lat"],
        long: json["long"],
        phone: json["phone"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "region": region,
        "address": address,
        "lat": lat,
        "long": long,
        "phone": phone,
      };
}
