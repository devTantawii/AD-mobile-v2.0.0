// To parse this JSON data, do
//
//     final areasModel = areasModelFromJson(jsonString);

List<AreasModel> areasModelFromJson(data) =>
    List<AreasModel>.from((data).map((x) => AreasModel.fromJson(x)));

// String areasModelToJson(AreasModel data) => json.encode(data.toJson());

class AreasModel {
  AreasModel({
    this.id,
    this.name,
    this.long,
    this.lat,
    this.regionId,
    this.radius,
  });

  int? id;
  String? name;
  String? long;
  String? lat;
  int? regionId;
  String? radius;

  factory AreasModel.fromJson(Map<String, dynamic> json) => AreasModel(
        id: json["id"] == null ? null : json["id"],
        name: json["name"] == null ? null : json["name"],
        long: json["long"] == null ? null : json["long"],
        lat: json["lat"] == null ? null : json["lat"],
        regionId: json["region_id"] == null ? null : json["region_id"],
        radius: json["radius"] == null ? null : json["radius"],
      );

  Map<String, dynamic> toJson() => {
        "id": id == null ? null : id,
        "name": name == null ? null : name,
        "long": long == null ? null : long,
        "lat": lat == null ? null : lat,
        "region_id": regionId == null ? null : regionId,
        "radius": radius == null ? null : radius,
      };
}
