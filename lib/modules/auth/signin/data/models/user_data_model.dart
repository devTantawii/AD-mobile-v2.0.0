// To parse this JSON data, do
//
//     final userData = userDataFromJson(jsonString);

import 'dart:convert';

UserData userDataFromJson(String str) => UserData.fromJson(json.decode(str));

String userDataToJson(UserData data) => json.encode(data.toJson());

class UserData {
  UserData({
    required this.data,
    required this.token,
  });

  Data data;
  String token;

  factory UserData.fromJson(Map<String, dynamic> json) => UserData(
        data: Data.fromJson(json["data"]),
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "data": data.toJson(),
        "token": token,
      };
}

class Data {
  Data({
    required this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.type,
    required this.status,
    required this.custmerData,
    required this.newCustmerRequest,
    required this.points,
    required this.favorite,
    required this.membership,
    required this.expDate,
    required this.avatar,
    required this.localedType,
    required this.createdAt,
    required this.createdAtFormatted,
  });

  int id;
  String name;
  String email;
  String phone;
  String type;
  bool status;
  CustmerData custmerData;
  CustmerData newCustmerRequest;
  int points;
  List<dynamic> favorite;
  Membership membership;
  DateTime expDate;
  String avatar;
  String localedType;
  DateTime createdAt;
  String createdAtFormatted;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        id: json["id"],
        name: json["name"],
        email: json["email"],
        phone: json["phone"],
        type: json["type"],
        status: json["status"],
        custmerData: CustmerData.fromJson(json["custmer_data"]),
        newCustmerRequest: CustmerData.fromJson(json["new_custmer_request"]),
        points: json["points"],
        favorite: List<dynamic>.from(json["favorite"].map((x) => x)),
        membership: Membership.fromJson(json["membership"]),
        expDate: DateTime.parse(json["Exp_date"]),
        avatar: json["avatar"],
        localedType: json["localed_type"],
        createdAt: DateTime.parse(json["created_at"]),
        createdAtFormatted: json["created_at_formatted"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "email": email,
        "phone": phone,
        "type": type,
        "status": status,
        "custmer_data": custmerData.toJson(),
        "new_custmer_request": newCustmerRequest.toJson(),
        "points": points,
        "favorite": List<dynamic>.from(favorite.map((x) => x)),
        "membership": membership.toJson(),
        "Exp_date":
            "${expDate.year.toString().padLeft(4, '0')}-${expDate.month.toString().padLeft(2, '0')}-${expDate.day.toString().padLeft(2, '0')}",
        "avatar": avatar,
        "localed_type": localedType,
        "created_at": createdAt.toIso8601String(),
        "created_at_formatted": createdAtFormatted,
      };
}

class CustmerData {
  CustmerData({
    required this.id,
    required this.idNumber,
    required this.idExpiryDate,
    required this.driverIdExpiryDate,
    required this.dateOfBirth,
    required this.nationality,
    this.gender,
    required this.address,
    this.postBox,
    required this.driverNumber,
    required this.isConfirmed,
    required this.description,
  });

  int id;
  String idNumber;
  DateTime idExpiryDate;
  DateTime driverIdExpiryDate;
  DateTime dateOfBirth;
  String nationality;
  dynamic gender;
  String address;
  dynamic postBox;
  String driverNumber;
  String isConfirmed;
  String description;

  factory CustmerData.fromJson(Map<String, dynamic> json) => CustmerData(
        id: json["id"],
        idNumber: json["id_number"],
        idExpiryDate: DateTime.parse(json["id_expiry_date"]),
        driverIdExpiryDate: DateTime.parse(json["driver_id_expiry_date"]),
        dateOfBirth: DateTime.parse(json["date_of_birth"]),
        nationality: json["nationality"],
        gender: json["gender"],
        address: json["address"],
        postBox: json["post_box"],
        driverNumber: json["driver_number"],
        isConfirmed: json["is_confirmed"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_number": idNumber,
        "id_expiry_date":
            "${idExpiryDate.year.toString().padLeft(4, '0')}-${idExpiryDate.month.toString().padLeft(2, '0')}-${idExpiryDate.day.toString().padLeft(2, '0')}",
        "driver_id_expiry_date":
            "${driverIdExpiryDate.year.toString().padLeft(4, '0')}-${driverIdExpiryDate.month.toString().padLeft(2, '0')}-${driverIdExpiryDate.day.toString().padLeft(2, '0')}",
        "date_of_birth":
            "${dateOfBirth.year.toString().padLeft(4, '0')}-${dateOfBirth.month.toString().padLeft(2, '0')}-${dateOfBirth.day.toString().padLeft(2, '0')}",
        "nationality": nationality,
        "gender": gender,
        "address": address,
        "post_box": postBox,
        "driver_number": driverNumber,
        "is_confirmed": isConfirmed,
        "description": description,
      };
}

class Membership {
  Membership({
    required this.id,
    required this.name,
    required this.image,
    required this.rentalDiscount,
    required this.ratioPoints,
    required this.extraHours,
    required this.allowedKilos,
    required this.deliveryDiscountRegions,
    required this.description,
  });

  int id;
  String name;
  String image;
  int rentalDiscount;
  int ratioPoints;
  int extraHours;
  int allowedKilos;
  int deliveryDiscountRegions;
  String description;

  factory Membership.fromJson(Map<String, dynamic> json) => Membership(
        id: json["id"],
        name: json["name"],
        image: json["image"],
        rentalDiscount: json["rental_discount"],
        ratioPoints: json["ratio_points"],
        extraHours: json["extra_hours"],
        allowedKilos: json["allowed_Kilos"],
        deliveryDiscountRegions: json["delivery_discount_regions"],
        description: json["description"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "rental_discount": rentalDiscount,
        "ratio_points": ratioPoints,
        "extra_hours": extraHours,
        "allowed_Kilos": allowedKilos,
        "delivery_discount_regions": deliveryDiscountRegions,
        "description": description,
      };
}
