class CategoryModelData {
  CategoryModelData();
  List<Data> data = [];
  CategoryModelData.fromJson(Map<String, dynamic> json) {
    json['data'].forEach((e) {
      data.add(Data.fromJson(e));
    });
  }
}

class Data {
  int? id;
  String? name;
  String? icon;
  int? car;
  Data.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    icon = json['icon'];
    car = json['car'];
  }
}
