import 'dart:convert';

enum StatusLicence { ACCEPTED, PENDING, DECLINED }

class ProfileModel {
  String? name;
  String? email;
  String? phone;
  int? points;
  String? membershipImageurl;
  Membership? membership;
  String? avatar;
  StatusLicence? stutusLicence;
  String? idNumber;
  String? date;
  String? custClass;
  String? deleteStatus;
  String? user_license;
  ProfileModel({
    this.name,
    this.email,
    this.phone,
    this.points,
    this.membershipImageurl,
    this.membership,
    this.avatar,
    this.stutusLicence,
    this.idNumber,
    this.date,
    this.custClass,
    this.deleteStatus,
    this.user_license,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'points': points,
      'membership_img': membershipImageurl,
      "membership": membership,
      'avatar': avatar,
      'localed_type': custClass,
      'delete_status': deleteStatus,
      'user_license': user_license,
    };
  }

  factory ProfileModel.fromMap(Map<String, dynamic> map) {
    StatusLicence stutusLicence;

    switch (map['new_custmer_request']['is_confirmed']) {
      case "pending":
        stutusLicence = StatusLicence.PENDING;

        break;
      case "rejected":
        stutusLicence = StatusLicence.DECLINED;

        break;
      case "confirmed":
        stutusLicence = StatusLicence.ACCEPTED;

        break;
      default:
        stutusLicence = StatusLicence.PENDING;
    }
    return ProfileModel(
      name: map['name'],
      email: map['email'],
      phone: map['phone'],
      points: map['points'],
      membershipImageurl: map['membership']['image'],
      membership: Membership.fromMap(map["membership"]),
      avatar: map['avatar'],
      stutusLicence: stutusLicence,
      idNumber: map['new_custmer_request']['is_confirmed'],
      date: map['Exp_date'],
      custClass: map['cust_class'],
      deleteStatus: map['delete_status'],
      user_license: map['user_license'],
    );
  }

  String toJson() => json.encode(toMap());

  factory ProfileModel.fromJson(String source) =>
      ProfileModel.fromMap(json.decode(source));
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

  int? id;
  String? name;
  String? image;
  int? rentalDiscount;
  int? ratioPoints;
  int? extraHours;
  int? allowedKilos;
  int? deliveryDiscountRegions;
  String? description;

  factory Membership.fromMap(Map<String, dynamic> json) => Membership(
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

  Map<String, dynamic> toMap() => {
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
