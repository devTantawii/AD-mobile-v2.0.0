class Manufactories {
  List<Data>? _data;

  Manufactories({List<Data>? data}) {
    if (data != null) {
      this._data = data;
    }
  }

  List<Data>? get data => _data;
  set data(List<Data>? data) => _data = data;

  Manufactories.fromJson(Map<String, dynamic> json) {
    if (json['data'] != null) {
      _data = <Data>[];
      json['data'].forEach((v) {
        _data!.add(new Data.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this._data != null) {
      data['data'] = this._data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Data {
  int? _id;
  String? _icon;
  String? _name;

  Data({int? id, String? icon, String? name}) {
    if (id != null) {
      this._id = id;
    }
    if (icon != null) {
      this._icon = icon;
    }
    if (name != null) {
      this._name = name;
    }
  }

  int? get id => _id;
  set id(int? id) => _id = id;
  String? get icon => _icon;
  set icon(String? icon) => _icon = icon;
  String? get name => _name;
  set name(String? name) => _name = name;

  Data.fromJson(Map<String, dynamic> json) {
    _id = json['id'];
    _icon = json['icon'];
    _name = json['name'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this._id;
    data['icon'] = this._icon;
    data['name'] = this._name;
    return data;
  }
}