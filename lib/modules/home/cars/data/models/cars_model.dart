// To parse this JSON data, do
//
//     final cars = carsFromMap(jsonString);

import 'dart:convert';

Cars carsFromMap(String str) => Cars.fromMap(json.decode(str));

String carsToMap(Cars data) => json.encode(data.toMap());

class Cars {
  Cars({
    required this.data,
    this.meta,
  });

  List<DataCars>? data;
  Meta ? meta;
  Cars copyWith({
    required List<DataCars> data,
    required Meta meta,

  }) =>
      Cars(
        data: data,
         meta: meta,
      );

  factory Cars.fromMap(Map<String, dynamic> json) => Cars(
        data: List<DataCars>.from(json["data"]?.map((x) => DataCars.fromMap(x))),
        meta:Meta.fromJson(json["meta"]),
      );

  Map<String, dynamic> toMap() => {
        "data": List<dynamic>.from(data?.map((x) => x.toMap()) ?? []),
        "meta": meta??null,
      };
}

class DataCars {
  DataCars({
    required this.id,
    required this.name,
    required this.model,
    required this.categoryId,
    required this.category,
    required this.manufactory,
    required this.priceBefore,
    required this.priceAfter,
    required this.discount,
    required this.doors,
    required this.luggage,
    required this.transmission,
    required this.isFavorite,
    required this.description,
    required this.photo,
    required this.photos,
    //required this.available,
  });

  num id;
  String name;
  num model;
  num categoryId;
  String category;
  String manufactory;
  num priceBefore;
  num priceAfter;
  num discount;
  num doors;
  num luggage;
  String transmission;
  bool isFavorite;
  String description;
  String photo;
  List<Photo>? photos;
  //int available;

  DataCars copyWith({
    required num id,
    required String name,
    required num model,
    required num categoryId,
    required String category,
    required String manufactory,
    required num priceBefore,
    required num priceAfter,
    required num discount,
    required num doors,
    required num luggage,
    required String transmission,
    required bool isFavorite,
    required String description,
    required String photo,
    required List<Photo> photos,
    //required int available,
  }) =>
      DataCars(
        id: id,
        name: name,
        model: model,
        categoryId: categoryId,
        category: category,
        manufactory: manufactory,
        priceBefore: priceBefore,
        priceAfter: priceAfter,
        discount: discount,
        doors: doors,
        luggage: luggage,
        transmission: transmission,
        isFavorite: isFavorite,
        description: description,
        photo: photo,
        photos: photos,
        //available: available,
      );

  factory DataCars.fromMap(Map<String, dynamic> json) => DataCars(
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
        photos: List<Photo>.from(json["photos"].map((x) => Photo.fromMap(x))),
      // available: json["available"],
      );

  Map<String, dynamic> toMap() => {
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
        "photos": List<dynamic>.from(photos?.map((x) => x.toMap()) ?? []),
        //"available": available,
      };
}

class Photo {
  Photo({
    required this.id,
    required this.url,
    required this.preview,
    required this.name,
    required this.fileName,
    required this.type,
    required this.mimeType,
    required this.size,
    required this.humanReadableSize,
    required this.details,
    required this.status,
    required this.progress,

  });

  num? id;
  String? url;
  String? preview;
  String? name;
  String? fileName;
  String? type;
  String? mimeType;
  num size;
  String? humanReadableSize;
  Details? details;
  String? status;
  num? progress;


  Photo copyWith({
    required num id,
    required String url,
    required String preview,
    required String name,
    required String fileName,
    required String type,
    required String mimeType,
    required num size,
    required String humanReadableSize,
    required Details details,
    required String status,
    required num progress,

  }) =>
      Photo(
        id: id,
        url: url,
        preview: preview,
        name: name,
        fileName: fileName,
        type: type,
        mimeType: mimeType,
        size: size,
        humanReadableSize: humanReadableSize,
        details: details,
        status: status,
        progress: progress,

      );

  factory Photo.fromMap(Map<String, dynamic> json) => Photo(
        id: json["id"],
        url: json["url"],
        preview: json["preview"],
        name: json["name"],
        fileName: json["file_name"],
        type: json["type"],
        mimeType: json["mime_type"],
        size: json["size"],
        humanReadableSize: json["human_readable_size"],
        details: Details.fromMap(json["details"]),
        status: json["status"] ?? "",
        progress: json["progress"] ?? 0,

      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "url": url,
        "preview": preview,
        "name": name,
        "file_name": fileName,
        "type": type,
        "mime_type": mimeType,
        "size": size,
        "human_readable_size": humanReadableSize,
        "details": details?.toMap(),
        "status": status,
        "progress": progress,

      };
}

class Details {
  Details({
    required this.width,
    required this.height,
    required this.ratio,
  });

  num width;
  num height;
  num ratio;

  Details copyWith({
    required num width,
    required num height,
    required num ratio,
  }) =>
      Details(
        width: width,
        height: height,
        ratio: ratio,
      );

  factory Details.fromMap(Map<String, dynamic> json) => Details(
        width: json["width"] ?? 0,
        height: json["height"] ?? 0,
        ratio: json["ratio"].toDouble(),
      );

  Map<String, dynamic> toMap() => {
        "width": width,
        "height": height,
        "ratio": ratio,
      };
}

class Delete {
  Delete({
    required this.href,
    required this.method,
  });

  String? href;
  String? method;

  Delete copyWith({
    required String href,
    required String method,
  }) =>
      Delete(
        href: href,
        method: method,
      );

  factory Delete.fromMap(Map<String, dynamic> json) => Delete(
        href: json["href"],
        method: json["method"],
      );

  Map<String, dynamic> toMap() => {
        "href": href,
        "method": method,
      };
}

class Meta {
  int? currentPage;
  int? from;
  int? lastPage;
  String? path;
  int? perPage;
  int? to;
  int? total;

  Meta(
      {this.currentPage,
        this.from,
        this.lastPage,

        this.path,
        this.perPage,
        this.to,
        this.total});

  Meta.fromJson(Map<String, dynamic> json) {
    currentPage = json['current_page'];
    from = json['from'];
    lastPage = json['last_page'];
    path = json['path'];
    perPage = json['per_page'];
    to = json['to'];
    total = json['total'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['current_page'] = this.currentPage;
    data['from'] = this.from;
    data['last_page'] = this.lastPage;
    data['path'] = this.path;
    data['per_page'] = this.perPage;
    data['to'] = this.to;
    data['total'] = this.total;
    return data;
  }
}