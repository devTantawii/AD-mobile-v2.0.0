import 'dart:convert';

import '../../../cars/data/models/cars_model.dart';

CheckOrderStepModel bookingFromMap(String str) =>
    CheckOrderStepModel.fromMap(json.decode(str) as Map<String, dynamic>);

String CheckOrderStepModelToMap(CheckOrderStepModel data) => json.encode(data.toMap());
class CheckOrderStepModel {
  bool? status;
  Order? order;

  CheckOrderStepModel({this.status, this.order});

  CheckOrderStepModel.fromMap(Map<String, dynamic> json) {
    status = json['status'];
    order = json['order'] != null ? new Order.fromJson(json['order']) : null;
  }

  Map<String, dynamic> toMap() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    if (this.order != null) {
      data['order'] = this.order!.toJson();
    }
    return data;
  }
}

class Order {
  dynamic id;
  Car? car;
  String? recivingDate;
  String? deliveryDate;
  String? receiveDate;
  String? receiveTime;
  String? deliverDate;
  String? deliverTime;
  List<AdditionsData>? additionsData;
  dynamic rentPrice;
  int? additions;
  dynamic tammPrice;
  dynamic total;
  dynamic membershipDiscount;
  dynamic promotionalDiscount;
  dynamic netPrice;
  String? vatValue;
  String? generalTotal;
  dynamic paymentType;
  dynamic paymentStatus;
  dynamic price;
  List<dynamic>? featuresAdded;
  String? createdAt;
  String? status;
  String? visaAmout;
  String? statusText;
  String? paymentStatment;
  bool? canCancel;
  String? visaaaa;
  String? receivePlace;
  String? deliverPlace;
  dynamic diff;
  dynamic step;
  List<Features>? features;
  bool? cashActive;
  bool? visaActive;
  bool? pointsActive;
  bool? apple_active;

  Order(
      {this.id,
        this.car,
        this.recivingDate,
        this.deliveryDate,
        this.receiveDate,
        this.receiveTime,
        this.deliverDate,
        this.deliverTime,
        this.additionsData,
        this.rentPrice,
        this.additions,
        this.tammPrice,
        this.total,
        this.membershipDiscount,
        this.promotionalDiscount,
        this.netPrice,
        this.vatValue,
        this.generalTotal,
        this.paymentType,
        this.paymentStatus,
        this.price,
        this.featuresAdded,
        this.createdAt,
        this.status,
        this.visaAmout,
        this.statusText,
        this.paymentStatment,
        this.canCancel,
        this.visaaaa,
        this.receivePlace,
        this.deliverPlace,
        this.diff,
        this.step,
        this.features,
        this.cashActive,
        this.visaActive,
        this.pointsActive,
        this.apple_active,

      });

  Order.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    car = json['car'] != null ? new Car.fromJson(json['car']) : null;
    recivingDate = json['reciving_date'];
    deliveryDate = json['delivery_date'];
    receiveDate = json['receive_date'];
    receiveTime = json['receive_time'];
    deliverDate = json['deliver_date'];
    deliverTime = json['deliver_time'];
    if (json['additions_data'] != null) {
      additionsData = <AdditionsData>[];
      json['additions_data'].forEach((v) {
        additionsData!.add(new AdditionsData.fromJson(v));
      });
    }
    rentPrice = json['rent_price'];
    additions = json['additions'];
    tammPrice = json['tamm_price'];
    total = json['total'];
    membershipDiscount = json['membership_discount'];
    promotionalDiscount = json['promotional_discount'];
    netPrice = json['net_price'];
    vatValue = json['vat_value'];
    generalTotal = json['general_total'];
    paymentType = json['payment_type'];
    paymentStatus = json['payment_status'];
    price = json['price'];
    featuresAdded = json['features_added'];
    createdAt = json['created_at'];
    status = json['status'];
    visaAmout = json['visa_amout'];
    statusText = json['status_text'];
    paymentStatment = json['payment_statment'];
    canCancel = json['can_cancel'];
    visaaaa = json['visaaaa'];
    receivePlace = json['receivePlace'];
    deliverPlace = json['deliverPlace'];
    diff = json['diff'];
    step = json['step'];
    if (json['features'] != null) {
      features = <Features>[];
      json['features'].forEach((v) {
        features!.add(new Features.fromJson(v));
      });
    }
    cashActive = json['cash_active'];
    visaActive = json['visa_active'];
    pointsActive = json['points_active'];
    apple_active = json['apple_active'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    if (this.car != null) {
      data['car'] = this.car!.toJson();
    }
    data['reciving_date'] = this.recivingDate;
    data['delivery_date'] = this.deliveryDate;
    data['receive_date'] = this.receiveDate;
    data['receive_time'] = this.receiveTime;
    data['deliver_date'] = this.deliverDate;
    data['deliver_time'] = this.deliverTime;
    if (this.additionsData != null) {
      data['additions_data'] =
          this.additionsData!.map((v) => v.toJson()).toList();
    }
    data['rent_price'] = this.rentPrice;
    data['additions'] = this.additions;
    data['tamm_price'] = this.tammPrice;
    data['total'] = this.total;
    data['membership_discount'] = this.membershipDiscount;
    data['promotional_discount'] = this.promotionalDiscount;
    data['net_price'] = this.netPrice;
    data['vat_value'] = this.vatValue;
    data['general_total'] = this.generalTotal;
    data['payment_type'] = this.paymentType;
    data['payment_status'] = this.paymentStatus;
    data['price'] = this.price;
    data['features_added'] = this.featuresAdded;
    data['created_at'] = this.createdAt;
    data['status'] = this.status;
    data['visa_amout'] = this.visaAmout;
    data['status_text'] = this.statusText;
    data['payment_statment'] = this.paymentStatment;
    data['can_cancel'] = this.canCancel;
    data['visaaaa'] = this.visaaaa;
    data['receivePlace'] = this.receivePlace;
    data['deliverPlace'] = this.deliverPlace;
    data['diff'] = this.diff;
    data['step'] = this.step;
    if (this.features != null) {
      data['features'] = this.features!.map((v) => v.toJson()).toList();
    }
    data['cash_active'] = this.cashActive;
    data['visa_active'] = this.visaActive;
    data['points_active'] = this.pointsActive;
    data['apple_active'] = this.apple_active;
    return data;
  }
}

class Car {
  dynamic id;
  String? name;
  dynamic model;
  dynamic categoryId;
  String? category;
  String? manufactory;
  dynamic priceBefore;
  dynamic priceAfter;
  dynamic discount;
  dynamic doors;
  dynamic luggage;
  String? transmission;
  bool? isFavorite;
  String? description;
  String? photo;
  List<Photos>? photos;
  dynamic available;

  Car(
      {this.id,
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
        this.available});

  Car.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    model = json['model'];
    categoryId = json['category_id'];
    category = json['category'];
    manufactory = json['manufactory'];
    priceBefore = json['price_before'];
    priceAfter = json['price_after'];
    discount = json['discount'];
    doors = json['doors'];
    luggage = json['luggage'];
    transmission = json['transmission'];
    isFavorite = json['is_favorite'];
    description = json['description'];
    photo = json['photo'];
    if (json['photos'] != null) {
      photos = <Photos>[];
      json['photos'].forEach((v) {
        photos!.add(new Photos.fromJson(v));
      });
    }
    available = json['available'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['name'] = this.name;
    data['model'] = this.model;
    data['category_id'] = this.categoryId;
    data['category'] = this.category;
    data['manufactory'] = this.manufactory;
    data['price_before'] = this.priceBefore;
    data['price_after'] = this.priceAfter;
    data['discount'] = this.discount;
    data['doors'] = this.doors;
    data['luggage'] = this.luggage;
    data['transmission'] = this.transmission;
    data['is_favorite'] = this.isFavorite;
    data['description'] = this.description;
    data['photo'] = this.photo;
    if (this.photos != null) {
      data['photos'] = this.photos!.map((v) => v.toJson()).toList();
    }
    data['available'] = this.available;
    return data;
  }
}

class Photos {
  dynamic id;
  String? url;
  String? preview;
  String? name;
  String? fileName;
  String? type;
  String? mimeType;
  dynamic size;
  String? humanReadableSize;
  Details? details;
  dynamic status;
  Links? links;

  Photos(
      {this.id,
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
        this.links});

  Photos.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    url = json['url'];
    preview = json['preview'];
    name = json['name'];
    fileName = json['file_name'];
    type = json['type'];
    mimeType = json['mime_type'];
    size = json['size'];
    humanReadableSize = json['human_readable_size'];
    details =
    json['details'] != null ? new Details.fromJson(json['details']) : null;
    status = json['status'];
    links = json['links'] != null ? new Links.fromJson(json['links']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['url'] = this.url;
    data['preview'] = this.preview;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['type'] = this.type;
    data['mime_type'] = this.mimeType;
    data['size'] = this.size;
    data['human_readable_size'] = this.humanReadableSize;
    if (this.details != null) {
      data['details'] = this.details!.toJson();
    }
    data['status'] = this.status;
    if (this.links != null) {
      data['links'] = this.links!.toJson();
    }
    return data;
  }
}

class Details {
  dynamic width;
  dynamic height;
  dynamic ratio;

  Details({this.width, this.height, this.ratio});

  Details.fromJson(Map<String, dynamic> json) {
    width = json['width'];
    height = json['height'];
    ratio = json['ratio'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['width'] = this.width;
    data['height'] = this.height;
    data['ratio'] = this.ratio;
    return data;
  }
}

class Links {
  Delete? delete;

  Links({this.delete});

  Links.fromJson(Map<String, dynamic> json) {
    delete =
    json['delete'] != null ? new Delete.fromJson(json['delete']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.delete != null) {
      data['delete'] = this.delete!.toJson();
    }
    return data;
  }
}

class Delete {
  String? href;
  String? method;

  Delete({this.href, this.method});

  Delete.fromJson(Map<String, dynamic> json) {
    href = json['href'];
    method = json['method'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['href'] = this.href;
    data['method'] = this.method;
    return data;
  }
}

class AdditionsData {
  dynamic id;
  String? type;
  // Icon? icon;
  String? name;
  dynamic miniDes;
  String? des;
  List<Translations>? translations;
  List<Media>? media;
  // bool  isChecked = false;  /// For me

  AdditionsData(
      {this.id,
        this.type,
        // this.icon,
        this.name,
        this.miniDes,
        this.des,
        this.translations,
        this.media,
        // this.isChecked = false
      });

  AdditionsData.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    type = json['type'];
    // icon = json['icon'] != null ? new Icon.fromJson(json['icon']) : null;
    name = json['name'];
    miniDes = json['mini_des'];
    des = json['des'];
    if (json['translations'] != null) {
      translations = <Translations>[];
      json['translations'].forEach((v) {
        translations!.add(new Translations.fromJson(v));
      });
    }
    if (json['media'] != null) {
      media = <Media>[];
      json['media'].forEach((v) {
        media!.add(new Media.fromJson(v));
      });
    }
    // isChecked = false;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['type'] = this.type;
    // if (this.icon != null) {
      // data['icon'] = this.icon!.toJson();
    // }
    data['name'] = this.name;
    data['mini_des'] = this.miniDes;
    data['des'] = this.des;
    if (this.translations != null) {
      data['translations'] = this.translations!.map((v) => v.toJson()).toList();
    }
    if (this.media != null) {
      data['media'] = this.media!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

// class Icon {
//   String? name;
//   String? type;
//
//   Icon({this.name, this.type});
//
//   Icon.fromJson(Map<String, dynamic> json) {
//     name = json['name'];
//     type = json['type'];
//   }
//
//   Map<String, dynamic> toJson() {
//     final Map<String, dynamic> data = new Map<String, dynamic>();
//     data['name'] = this.name;
//     data['type'] = this.type;
//     return data;
//   }
// }

class Translations {
  dynamic id;
  dynamic additionId;
  String? name;
  dynamic miniDes;
  String? des;
  String? locale;

  Translations(
      {this.id,
        this.additionId,
        this.name,
        this.miniDes,
        this.des,
        this.locale});

  Translations.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    additionId = json['addition_id'];
    name = json['name'];
    miniDes = json['mini_des'];
    des = json['des'];
    locale = json['locale'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['addition_id'] = this.additionId;
    data['name'] = this.name;
    data['mini_des'] = this.miniDes;
    data['des'] = this.des;
    data['locale'] = this.locale;
    return data;
  }
}

class Media {
  dynamic id;
  String? modelType;
  dynamic modelId;
  String? uuid;
  String? collectionName;
  String? name;
  String? fileName;
  String? mimeType;
  String? disk;
  String? conversionsDisk;
  dynamic size;
  dynamic orderColumn;
  String? createdAt;
  String? updatedAt;
  String? originalUrl;
  String? previewUrl;

  Media(
      {this.id,
        this.modelType,
        this.modelId,
        this.uuid,
        this.collectionName,
        this.name,
        this.fileName,
        this.mimeType,
        this.disk,
        this.conversionsDisk,
        this.size,
        this.orderColumn,
        this.createdAt,
        this.updatedAt,
        this.originalUrl,
        this.previewUrl});

  Media.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    modelType = json['model_type'];
    modelId = json['model_id'];
    uuid = json['uuid'];
    collectionName = json['collection_name'];
    name = json['name'];
    fileName = json['file_name'];
    mimeType = json['mime_type'];
    disk = json['disk'];
    conversionsDisk = json['conversions_disk'];
    size = json['size'];
    orderColumn = json['order_column'];
    createdAt = json['created_at'];
    updatedAt = json['updated_at'];
    originalUrl = json['original_url'];
    previewUrl = json['preview_url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['model_type'] = this.modelType;
    data['model_id'] = this.modelId;
    data['uuid'] = this.uuid;
    data['collection_name'] = this.collectionName;
    data['name'] = this.name;
    data['file_name'] = this.fileName;
    data['mime_type'] = this.mimeType;
    data['disk'] = this.disk;
    data['conversions_disk'] = this.conversionsDisk;
    data['size'] = this.size;
    data['order_column'] = this.orderColumn;
    data['created_at'] = this.createdAt;
    data['updated_at'] = this.updatedAt;
    data['original_url'] = this.originalUrl;
    data['preview_url'] = this.previewUrl;
    return data;
  }
}

class Features {
  dynamic id;
  String? title;
  dynamic subTitle;
  String? price;
  String? img;
  bool? daily;

  Features(
      {this.id, this.title, this.subTitle, this.price, this.img, this.daily});

  Features.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    subTitle = json['sub_title'];
    price = json['price'];
    img = json['img'];
    daily = json['daily'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['title'] = this.title;
    data['sub_title'] = this.subTitle;
    data['price'] = this.price;
    data['img'] = this.img;
    data['daily'] = this.daily;
    return data;
  }
}