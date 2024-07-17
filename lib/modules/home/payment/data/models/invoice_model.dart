// To parse this JSON data, do
//
//     final invoiceModel = invoiceModelFromJson(jsonString);

import 'dart:convert';

InvoiceModel invoiceModelFromJson(String str) =>
    InvoiceModel.fromJson(json.decode(str));

String invoiceModelToJson(InvoiceModel data) => json.encode(data.toJson());

class InvoiceModel {
  InvoiceModel({
    this.status,
    this.promotionalDiscount,
    this.car_discount,
    this.total,
    this.general_total,
    this.diff,
    this.taxValue,
    this.featuresPrice,
    this.price,
    this.beforeTax,
    this.areaPricing,
    this.authorizationFee,
    this.membershipDiscount,
    this.cashActive,
    this.visaActive,
    this.pointsActive,
    this.apple_active,
    this.order,
  });

  bool? status;
  String? promotionalDiscount;
  dynamic car_discount;
  String? total;
  String? general_total;
  dynamic diff;
  String? taxValue;
  String? featuresPrice;
  dynamic price;
  String? beforeTax;
  String? areaPricing;
  dynamic authorizationFee;
  String? membershipDiscount;
  bool? cashActive;
  bool? visaActive;
  bool? pointsActive;
  bool? apple_active;
  Order? order;

  factory InvoiceModel.fromJson(Map<String, dynamic> json) => InvoiceModel(
        status: json["status"],
        promotionalDiscount: json["promotional_discount"],
        car_discount: json["car_discount"],
        total: json["total"],
        general_total: json["general_total"],
        diff: json["diff"],
        taxValue: json["tax_value"],
        featuresPrice: json["features_price"],
        price: double.parse(json["price"].toString()),
        beforeTax: json["before_tax"],
        areaPricing: json["Area_pricing"],
        authorizationFee: json["authorization_fee"],
        membershipDiscount: json["membership_discount"],
        cashActive: json["cash_active"],
        visaActive: json["visa_active"],
        pointsActive: json["points_active"],
        apple_active: json["apple_active"],
        order: Order.fromJson(json["order"]),
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "promotional_discount": promotionalDiscount,
        "total": total,
        "general_total": general_total,
        "diff": diff,
        "tax_value": taxValue,
        "features_price": featuresPrice,
        "price": price,
        "before_tax": beforeTax,
        "Area_pricing": areaPricing,
        "authorization_fee": authorizationFee,
        "membership_discount": membershipDiscount,
        "cash_active": cashActive,
        "visa_active": visaActive,
        "points_active": pointsActive,
        "apple_active": apple_active,
        "order": order?.toJson(),
      };
}

class Order {
  Order({
    this.id,
    this.car,
    this.recivingDate,
    this.receive_date,
    this.deliver_date,
    this.deliver_time,
    this.receive_time,
    this.deliveryDate,
    this.receivePlace,
    this.deliverPlace,
    this.paymentType,
    this.paymentStatus,
    this.price,
    this.featuresAdded,
    this.createdAt,
    this.status,
    this.visaAmout,
    this.statusText,
    this.paymentStatment,
  });

  int? id;
  Car? car;
  String? recivingDate;
  String? deliveryDate;
  String? receive_date;
  String? deliver_date;
  String? receive_time;
  String? deliver_time;
  String? receivePlace;
  String? deliverPlace;
  dynamic paymentType;
  dynamic paymentStatus;
  String? price;
  List<String>? featuresAdded;
  String? createdAt;
  String? status;
  dynamic visaAmout;
  String? statusText;
  String? paymentStatment;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        car: Car.fromJson(json["car"]),
        receive_date: json["receive_date"],
        deliver_date: json["deliver_date"],
        receive_time: json["receive_time"],
        deliver_time: json["deliver_time"],
        deliverPlace: json["deliverPlace"],
        receivePlace: json["receivePlace"],

        ///------------------------------------
        recivingDate: json["reciving_date"],
        deliveryDate: json["delivery_date"],
        paymentType: json["payment_type"],
        paymentStatus: json["payment_status"],
        price: json["price"],
        featuresAdded: List<String>.from(
            (json["features_added"]?.map((x) => x.toString()) ?? [])),
        createdAt: json["created_at"],
        status: json["status"],
        visaAmout: json["visa_amout"],
        statusText: json["status_text"],
        paymentStatment: json["payment_statment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "car": car?.toJson(),
        "reciving_date": recivingDate,
        "delivery_date": deliveryDate,
        "payment_type": paymentType,
        "payment_status": paymentStatus,
        "price": price,
        "features_added": List<dynamic>.from(featuresAdded!.map((x) => x)),
        "created_at": createdAt,
        "status": status,
        "visa_amout": visaAmout,
        "status_text": statusText,
        "payment_statment": paymentStatment,
      };
}

class Car {
  Car({
    this.id,
    this.name,
    this.model,
    this.categoryId,
    this.category,
    this.manufactory,
    this.priceBefore,
    this.priceAfter,
    this.discount,
    this.doors,
    this.luggage,
    this.transmission,
    this.isFavorite,
    this.description,
    this.photo,
    // this.photos,
    this.available,
  });

  dynamic id;
  String? name;
  dynamic model;
  dynamic categoryId;
  String? category;
  String? manufactory;
  dynamic priceBefore;
  dynamic priceAfter;
  dynamic discount;
  dynamic doors;
  dynamic luggage;
  String? transmission;
  bool? isFavorite;
  String? description;
  String? photo;

  // List<Photo>? photos;
  dynamic available;

  factory Car.fromJson(Map<String, dynamic> json) => Car(
        id: json["id"],
        name: json["name"],
        model: json["model"],
        categoryId: json["category_id"],
        category: json["category"],
        manufactory: json["manufactory"],
        priceBefore: json["price_before"],
        priceAfter: json["price_after"],
        discount: json["discount"],
        doors: json["doors"],
        luggage: json["luggage"],
        transmission: json["transmission"],
        isFavorite: json["is_favorite"],
        description: json["description"],
        photo: json["photo"],
        // photos: List<Photo>.from(json["photos"].map((x) => Photo.fromJson(x))),
        available: json["available"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "model": model,
        "category_id": categoryId,
        "category": category,
        "manufactory": manufactory,
        "price_before": priceBefore,
        "price_after": priceAfter,
        "discount": discount,
        "doors": doors,
        "luggage": luggage,
        "transmission": transmission,
        "is_favorite": isFavorite,
        "description": description,
        "photo": photo,
        // "photos": List<dynamic>.from(photos?.map((x) => x.toJson()) ?? []),
        "available": available,
      };
}
