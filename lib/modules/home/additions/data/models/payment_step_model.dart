import 'dart:convert';

PaymentStepModel paymentStepModelFromJson(String str) =>
    PaymentStepModel.fromJson(json.decode(str));

String paymentStepModelToJson(PaymentStepModel data) =>
    json.encode(data.toJson());

class PaymentStepModel {
  PaymentStepModel({
    this.status,
    this.order,
    this.paymentUrl,
  });

  bool? status;
  Order? order;
  String? paymentUrl;

  factory PaymentStepModel.fromJson(Map<String, dynamic> json) =>
      PaymentStepModel(
        status: json["status"],
        order: Order.fromJson(json["order"]),
        paymentUrl: json["payment_url"],
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "order": order?.toJson(),
        "payment_url": paymentUrl,
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
  String? paymentType;
  dynamic paymentStatus;
  double? price;
  List<dynamic>? featuresAdded;
  String? createdAt;
  String? status;
  String? visaAmout;
  String? statusText;
  String? paymentStatment;

  factory Order.fromJson(Map<String, dynamic>? json) => Order(
        id: json?["id"],
        car: Car.fromJson(json?["car"]),
        recivingDate: json?["reciving_date"],
        deliveryDate: json?["delivery_date"],
        paymentType: json?["payment_type"],
        paymentStatus: json?["payment_status"],
        price: double.parse(json?["price"]?.toString() ?? "0.0"),
        featuresAdded:
            List<dynamic>.from(json?["features_added"]?.map((x) => x) ?? []),
        createdAt: json?["created_at"],
        status: json?["status"],
        visaAmout: json?["visa_amout"],
        statusText: json?["status_text"],
        paymentStatment: json?["payment_statment"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "car": car?.toJson(),
        "reciving_date": recivingDate,
        "delivery_date": deliveryDate,
        "payment_type": paymentType,
        "payment_status": paymentStatus,
        "price": price,
        "features_added": List<dynamic>.from(featuresAdded!.map((x) => x)),
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
  dynamic priceBefore;
  dynamic priceAfter;
  int? discount;
  int? doors;
  int? luggage;
  String? transmission;
  bool? isFavorite;
  String? description;
  String? photo;
  List<Photo>? photos;
  dynamic available;

  factory Car.fromJson(Map<String, dynamic>? json) => Car(
        id: json?["id"],
        name: json?["name"],
        model: json?["model"],
        categoryId: json?["category_id"],
        category: json?["category"],
        manufactory: json?["manufactory"],
        priceBefore: json?["price_before"],
        priceAfter: json?["price_after"],
        discount: json?["discount"],
        doors: json?["doors"],
        luggage: json?["luggage"],
        transmission: json?["transmission"],
        isFavorite: json?["is_favorite"],
        description: json?["description"],
        photo: json?["photo"],
        photos: List<Photo>.from(
            json?["photos"]?.map((x) => Photo.fromJson(x)) ?? []),
        available: json?["available"],
      );

  Map<String, dynamic> toJson() => {
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
        "photos": List<dynamic>.from(photos!.map((x) => x.toJson())),
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

  factory Photo.fromJson(Map<String, dynamic> json) => Photo(
        id: json["id"],
        url: json["url"],
        preview: json["preview"],
        name: json["name"],
        fileName: json["file_name"],
        type: json["type"],
        mimeType: json["mime_type"],
        size: json["size"],
        humanReadableSize: json["human_readable_size"],
        details: Details.fromJson(json["details"]),
        status: json["status"],
        progress: json["progress"],
        links: Links.fromJson(json["links"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "url": url,
        "preview": preview,
        "name": name,
        "file_name": fileName,
        "type": type,
        "mime_type": mimeType,
        "size": size,
        "human_readable_size": humanReadableSize,
        "details": details?.toJson(),
        "status": status,
        "progress": progress,
        "links": links?.toJson(),
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

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        width: json["width"],
        height: json["height"],
        ratio: json["ratio"].toDouble(),
      );

  Map<String, dynamic> toJson() => {
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

  factory Links.fromJson(Map<String, dynamic> json) => Links(
        delete: Delete.fromJson(json["delete"]),
      );

  Map<String, dynamic> toJson() => {
        "delete": delete?.toJson(),
      };
}

class Delete {
  Delete({
    this.href,
    this.method,
  });

  String? href;
  String? method;

  factory Delete.fromJson(Map<String, dynamic> json) => Delete(
        href: json["href"],
        method: json["method"],
      );

  Map<String, dynamic> toJson() => {
        "href": href,
        "method": method,
      };
}
