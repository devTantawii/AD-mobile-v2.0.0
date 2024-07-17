// To parse this JSON data, do
//
//     final stepOneOrderModel = stepOneOrderModelFromMap(jsonString);
import 'dart:convert';


StepOneOrderModel stepOneOrderModelFromMap(String str) =>
    StepOneOrderModel.fromMap(json.decode(str) as Map<String, dynamic>);

String stepOneOrderModelToMap(StepOneOrderModel data) =>
    json.encode(data.toMap());

class StepOneOrderModel {
  StepOneOrderModel({
    this.status,
    this.order,
    this.diff,
    this.features,
    this.cashActive,
    this.pointsActive,
    this.visaActive,
    this.apple_active,
  });

  bool? status;
  Order? order;
  bool? visaActive;
  bool? cashActive;
  bool? pointsActive;
  bool? apple_active;
  int? diff;
  List<Feature?>? features;

  factory StepOneOrderModel.fromMap(Map<String, dynamic> json) =>
      StepOneOrderModel(
        status: json["status"],
        cashActive: json["cash_active"],
        visaActive: json["visa_active"],
        pointsActive: json["points_active"],
        apple_active: json["apple_active"],
        diff: json["diff"],
        order: Order.fromMap(json["order"]),
        features:
            List<Feature>.from(json["features"].map((x) => Feature.fromMap(x))),
      );

  Map<String, dynamic> toMap() => {
        "status": status,
        "visa_active": visaActive,
        "cash_active": cashActive,
        "points_active": pointsActive,
        "apple_active": apple_active,
        "order": order?.toMap(),
    "features": List<dynamic>.from(features!.map((x) => x?.toMap())),
      };
}

class Feature {
  Feature({
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

  factory Feature.fromMap(Map<String, dynamic> json) => Feature(
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

class Order {
  Order({
    this.id,
    this.car,
    this.recivingDate,
    this.deliveryDate,
    this.paymentType,
    this.paymentStatus,
    this.price,
    this.featuresAdded,
    this.createdAt,
    this.status,
    this.visaAmout,
    this.statusText,
    this.paymentStatment,
  });

  int? id;
  Car? car;
  String? recivingDate;
  String? deliveryDate;
  dynamic paymentType;
  dynamic paymentStatus;
  dynamic price;
  dynamic featuresAdded;
  String? createdAt;
  String? status;
  String? visaAmout;
  String? statusText;
  String? paymentStatment;

  factory Order.fromMap(Map<String, dynamic> json) => Order(
        id: json["id"],
        car: Car.fromMap(json["car"]),
        recivingDate: json["reciving_date"],
        deliveryDate: json["delivery_date"],
        paymentType: json["payment_type"],
        paymentStatus: json["payment_status"],
        price: json["price"],
        featuresAdded: json["features_added"],
        createdAt: json["created_at"],
        status: json["status"],
        visaAmout: json["visa_amout"],
        statusText: json["status_text"],
        paymentStatment: json["payment_statment"],
      );

  Map<String, dynamic> toMap() => {
        "id": id,
        "car": car?.toMap(),
        "reciving_date": recivingDate,
        "delivery_date": deliveryDate,
        "payment_type": paymentType,
        "payment_status": paymentStatus,
        "price": price,
        "features_added": featuresAdded,
        "created_at": createdAt,
        "status": status,
        "visa_amout": visaAmout,
        "status_text": statusText,
        "payment_statment": paymentStatment,
      };
}

class Car {
  Car({
    this.id,
    this.name,
    this.model,
    this.categoryId,
    this.category,
    this.manufactory,
    this.priceBefore,
    this.priceAfter,
    this.discount,
    this.doors,
    this.luggage,
    this.transmission,
    this.isFavorite,
    this.description,
    this.photo,
    this.photos,
    this.available,
  });

  int? id;
  String? name;
  int? model;
  int? categoryId;
  String? category;
  String? manufactory;
  int? priceBefore;
  dynamic priceAfter;
  int? discount;
  int? doors;
  int? luggage;
  String? transmission;
  bool? isFavorite;
  String? description;
  String? photo;
  List<Photo?>? photos;
  dynamic available;

  factory Car.fromMap(Map<String, dynamic> json) => Car(
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
        available: json["available"],
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
        "photos": List<dynamic>.from(photos?.map((x) => x?.toMap()) ?? []),
        "available": available,
      };
}

class Photo {
  Photo({
    this.id,
    this.url,
    this.preview,
    this.name,
    this.fileName,
    this.type,
    this.mimeType,
    this.size,
    this.humanReadableSize,
    this.details,
    this.status,
    this.progress,
    this.links,
  });

  int? id;
  String? url;
  String? preview;
  String? name;
  String? fileName;
  String? type;
  String? mimeType;
  int? size;
  String? humanReadableSize;
  Details? details;
  String? status;
  int? progress;
  Links? links;

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
        status: json["status"],
        progress: json["progress"],
        links: Links.fromMap(json["links"]),
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
        "links": links?.toMap(),
      };
}

class Details {
  Details({
    this.width,
    this.height,
    this.ratio,
  });

  int? width;
  int? height;
  double? ratio;

  factory Details.fromMap(Map<String, dynamic> json) => Details(
        width: json["width"],
        height: json["height"],
        ratio: json["ratio"]?.toDouble() ?? 0.0,
      );

  Map<String, dynamic> toMap() => {
        "width": width,
        "height": height,
        "ratio": ratio,
      };
}

class Links {
  Links({
    this.delete,
  });

  Delete? delete;

  factory Links.fromMap(Map<String, dynamic> json) => Links(
        delete: Delete.fromMap(json["delete"]),
      );

  Map<String, dynamic> toMap() => {
        "delete": delete?.toMap(),
      };
}

class Delete {
  Delete({
    this.href,
    this.method,
  });

  String? href;
  String? method;

  factory Delete.fromMap(Map<String, dynamic> json) => Delete(
        href: json["href"],
        method: json["method"],
      );

  Map<String, dynamic> toMap() => {
        "href": href,
        "method": method,
      };
}
