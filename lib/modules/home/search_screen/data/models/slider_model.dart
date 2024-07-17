// To parse this JSON data, do
//
//     final sliderModel = sliderModelFromMap(jsonString);

import 'dart:convert';

SliderModel sliderModelFromMap(String str) =>
    SliderModel.fromMap(json.decode(str));

String sliderModelToMap(SliderModel data) => json.encode(data.toMap());

class SliderModel {
  SliderModel({
    required this.data,
  });

  List<Datum> data;

  factory SliderModel.fromMap(Map<String, dynamic> json) => SliderModel(
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
    required this.firstHeader,
    required this.secondHeader,
    required this.isMobile,
    required this.image,
  });

  int id;
  String name;
  dynamic firstHeader;
  dynamic secondHeader;
  int isMobile;
  String image;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        name: json["name"],
        firstHeader: json["first_header"],
        secondHeader: json["second_header"],
        isMobile: json["is_mobile"],
        image: json["phone_image"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "name": name,
        "first_header": firstHeader,
        "second_header": secondHeader,
        "is_mobile": isMobile,
        "phone_image": image,
      };
}
