class Favorite {
  Favorite({
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

  factory Favorite.fromMap(Map<String, dynamic> json) => Favorite(
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
    "photos": List<dynamic>.from(photos!.map((x) => x.toMap())),
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
  Type? type;
  MimeType? mimeType;
  int? size;
  String? humanReadableSize;
  Details? details;
  Status? status;
  int? progress;
  Links? links;

  factory Photo.fromMap(Map<String, dynamic> json) => Photo(
    id: json["id"],
    url: json["url"],
    preview: json["preview"],
    name: json["name"],
    fileName: json["file_name"],
    type: typeValues.map[json["type"]],
    mimeType: mimeTypeValues.map[json["mime_type"]],
    size: json["size"],
    humanReadableSize: json["human_readable_size"],
    details: Details.fromMap(json["details"]),
    status: statusValues.map[json["status"]],
    progress: json["progress"],
    links: Links.fromMap(json["links"]),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "url": url,
    "preview": preview,
    "name": name,
    "file_name": fileName,
    "type": typeValues.reverse![type],
    "mime_type": mimeTypeValues.reverse![mimeType],
    "size": size,
    "human_readable_size": humanReadableSize,
    "details": details?.toMap(),
    "status": statusValues.reverse![status],
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
    ratio: json["ratio"].toDouble(),
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
    "delete": delete!.toMap(),
  };
}

class Delete {
  Delete({
    this.href,
    this.method,
  });

  String? href;
  Method? method;

  factory Delete.fromMap(Map<String, dynamic> json) => Delete(
    href: json["href"],
    method: methodValues.map[json["method"]]!,
  );

  Map<String, dynamic> toMap() => {
    "href": href,
    "method": methodValues.reverse![method],
  };
}

enum Method { DELETE }

final methodValues = EnumValues({
  "DELETE": Method.DELETE
});

enum MimeType { IMAGE_JPEG }

final mimeTypeValues = EnumValues({
  "image/jpeg": MimeType.IMAGE_JPEG
});

enum Status { PROCESSING }

final statusValues = EnumValues({
  "processing": Status.PROCESSING
});

enum Type { IMAGE }

final typeValues = EnumValues({
  "image": Type.IMAGE
});

class Membership {
  Membership({
    this.id,
    this.name,
    this.image,
    this.rentalDiscount,
    this.ratioPoints,
    this.extraHours,
    this.allowedKilos,
    this.deliveryDiscountRegions,
    this.description,
  });

  int? id;
  String? name;
  String? image;
  int? rentalDiscount;
  int? ratioPoints;
  int? extraHours;
  int? allowedKilos;
  int? deliveryDiscountRegions;
  String? description;

  factory Membership.fromMap(Map<String, dynamic> json) => Membership(
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

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String>? reverseMap = Map();

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
