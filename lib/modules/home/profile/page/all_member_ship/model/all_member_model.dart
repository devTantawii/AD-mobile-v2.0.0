import 'dart:convert';

AllMember allMemberFromMap(String str) => AllMember.fromMap(json.decode(str));

String allMemberToMap(AllMember data) => json.encode(data.toMap());

class AllMember {
  AllMember({
    required this.data,
  });

  List<Datum> data;

  factory AllMember.fromMap(Map<String, dynamic> json) => AllMember(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
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

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
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
