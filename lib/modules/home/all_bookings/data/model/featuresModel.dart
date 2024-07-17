
import 'dart:convert';

FeaturesModel featuresFromMap(String str) => FeaturesModel.fromMap(json.decode(str));

String featuresToMap(FeaturesModel data) => json.encode(data.toMap());

class FeaturesModel {
  FeaturesModel({
    required this.data,
  });

  List<FeatureNotCompletedModel>? data;

  FeaturesModel copyWith({
    required List<FeatureNotCompletedModel> data,
  }) =>
      FeaturesModel(
        data: data,
      );

  factory FeaturesModel.fromMap(Map<String, dynamic> json) => FeaturesModel(
    data: List<FeatureNotCompletedModel>.from(json["data"]?.map((x) => FeatureNotCompletedModel.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data?.map((x) => x.toMap()) ?? []),
  };
}
class FeatureNotCompletedModel {
  FeatureNotCompletedModel({
    this.id,
    this.title,
    this.subTitle,
    this.price,
    this.img,
    this.daily,
  });

  int? id;
  String? title;
  dynamic subTitle;
  String? price;
  String? img;
  bool? daily;

  factory FeatureNotCompletedModel.fromMap(Map<String, dynamic> json) => FeatureNotCompletedModel(
    id: json["id"],
    title: json["title"],
    subTitle: json["sub_title"],
    price: json["price"],
    img: json["img"],
    daily: json["daily"],
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "title": title,
    "sub_title": subTitle,
    "price": price,
    "img": img,
    "daily": daily,
  };
}