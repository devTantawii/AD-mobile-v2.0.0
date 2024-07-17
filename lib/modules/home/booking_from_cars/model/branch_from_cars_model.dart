import 'dart:convert';

BranchFromCarModel branchFromCarModelFromMap(String str) =>
    BranchFromCarModel.fromMap(json.decode(str));

String branchFromCarModelToMap(BranchFromCarModel data) =>
    json.encode(data.toMap());

class BranchFromCarModel {
  BranchFromCarModel({
    required this.data,
  });

  List<Datum> data;

  factory BranchFromCarModel.fromMap(Map<String, dynamic> json) =>
      BranchFromCarModel(
        data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data.map((x) => x.toMap())),
      };
}

class Datum {
  Datum({
    required this.id,
    required this.text,
    required this.image,
    required this.canBookToday,
  });

  int id;
  String text;
  String image;
  int canBookToday;

  factory Datum.fromMap(Map<String, dynamic> json) => Datum(
        id: json["id"],
        text: json["text"],
        image: json["image"],
        canBookToday: json["can_book_today"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "text": text,
        "image": image,
        "can_book_today": canBookToday,
      };
}
