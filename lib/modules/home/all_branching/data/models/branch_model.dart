import 'dart:convert';

Data branchModelFromMap(String str) => Data.fromMap(json.decode(str));

String dataModelToMap(Data data) => json.encode(data.toMap());

class Data {
  Data({
    required this.data,
    required this.links,
    required this.meta,
  });

  List<BranchModel> data;
  Links links;
  Meta meta;

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    data: List<BranchModel>.from(
        json["data"].map((x) => BranchModel.fromMap(x))),
    links: Links.fromMap(json["links"]),
    meta: Meta.fromMap(json["meta"]),
  );

  Map<String, dynamic> toMap() => {
    "data": List<dynamic>.from(data.map((x) => x.toMap())),
    "links": links.toMap(),
    "meta": meta.toMap(),
  };
}

class BranchModel {
  BranchModel({
    this.id,
    this.name,
    this.region,
    this.regionId,
    this.address,
    this.lat,
    this.long,
    this.phone,
    this.locationUrl,
    this.workTime,
    this.bookToday
  });

  int? id;
  String? name;
  String? region;
  int? regionId;
  String? address;
  String? lat;
  String? long;
  String? phone;
  String? locationUrl;
  WorkTime? workTime;
  int? bookToday;

  factory BranchModel.fromMap(Map<String, dynamic> json) => BranchModel(
    id: json["id"],
    name: json["name"],
    bookToday: json["book_today"],
    region: json["region"],
    regionId: json["region_id"],
    address: json["address"],
    lat: json["lat"],
    long: json["long"],
    phone: json["phone"],
    locationUrl: json["location_url"] == null ? null : json["location_url"],
    workTime: json["work_time"] != null
        ? WorkTime.fromMap(json["work_time"])
        : WorkTime(),
  );

  Map<String, dynamic> toMap() => {
    "id": id,
    "name": name,
    "region": region,
    "region_id": regionId,
    "address": address,
    "lat": lat,
    "long": long,
    "phone": phone,
    "location_url": locationUrl == null ? null : locationUrl,
    "work_time": workTime?.toMap(),
    "book_today": bookToday,
  };
}

enum Region { EMPTY, REGION }

final regionValues = EnumValues(
    {"المنطقه الوسطي": Region.EMPTY, "المنطقه الغربيه": Region.REGION});

class WorkTime {
  WorkTime({
    this.alldays,
    this.fri,
    this.sat,
    this.sun,
    this.mon,
    this.tue,
    this.wed,
    this.thu,
    this.openAllDays,
  });

  Alldays? alldays;
  Fri? fri;
  Mon? sat;
  Mon? sun;
  Mon? mon;
  Mon? tue;
  Mon? wed;
  Mon? thu;
  String? openAllDays;

  factory WorkTime.fromMap(Map<String, dynamic> json) => WorkTime(
    alldays: Alldays.fromMap(json["alldays"]),
    fri: Fri.fromMap(json["fri"]),
    sat: Mon.fromMap(json["sat"]),
    sun: Mon.fromMap(json["sun"]),
    mon: Mon.fromMap(json["mon"]),
    tue: Mon.fromMap(json["tue"]),
    wed: Mon.fromMap(json["wed"]),
    thu: Mon.fromMap(json["thu"]),
    openAllDays: json["openAllDays"],
  );

  Map<String, dynamic> toMap() => {
    "alldays": alldays?.toMap(),
    "fri": fri?.toMap(),
    "sat": sat?.toMap(),
    "sun": sun?.toMap(),
    "mon": mon?.toMap(),
    "tue": tue?.toMap(),
    "wed": wed?.toMap(),
    "thu": thu?.toMap(),
    "openAllDays": openAllDays,
  };
}

class Alldays {
  Alldays({
    this.period,
    this.morning,
    this.afternone,
  });

  String? period;
  Afternone? morning;
  Afternone? afternone;

  factory Alldays.fromMap(Map<String, dynamic> json) => Alldays(
    period: json["period"],
    morning: Afternone.fromMap(json["morning"]),
    afternone: Afternone.fromMap(json["afternone"]),
  );

  Map<String, dynamic> toMap() => {
    "period": period,
    "morning": morning?.toMap(),
    "afternone": afternone?.toMap(),
  };
}

class Afternone {
  Afternone({
    this.timeopen,
    this.timeclose,
  });

  String? timeopen;
  String? timeclose;

  factory Afternone.fromMap(Map<String, dynamic> json) => Afternone(
    timeopen: json["timeopen"] == null ? null : json["timeopen"],
    timeclose: json["timeclose"] == null ? null : json["timeclose"],
  );

  Map<String, dynamic> toMap() => {
    "timeopen": timeopen == null ? null : timeopen,
    "timeclose": timeclose == null ? null : timeclose,
  };
}

class Fri {
  Fri({
    this.period,
    this.morning,
    this.afternone,
    this.lock,
  });

  String? period;
  Afternone? morning;
  Afternone? afternone;
  String? lock;

  factory Fri.fromMap(Map<String, dynamic> json) => Fri(
    period: json["period"],
    morning: Afternone.fromMap(json["morning"]),
    afternone: Afternone.fromMap(json["afternone"]),
    lock: json["lock"],
  );

  Map<String, dynamic> toMap() => {
    "period": period,
    "morning": morning?.toMap(),
    "afternone": afternone?.toMap(),
    "lock": lock,
  };
}

class Mon {
  Mon({
    this.lock,
  });

  String? lock;

  factory Mon.fromMap(Map<String, dynamic> json) => Mon(
    lock: json["lock"],
  );

  Map<String, dynamic> toMap() => {
    "lock": lock,
  };
}

class Links {
  Links({
    this.first,
    this.last,
    this.prev,
    this.next,
  });

  String? first;
  String? last;
  dynamic prev;
  String? next;

  factory Links.fromMap(Map<String, dynamic> json) => Links(
    first: json["first"],
    last: json["last"],
    prev: json["prev"],
    next: json["next"],
  );

  Map<String, dynamic> toMap() => {
    "first": first,
    "last": last,
    "prev": prev,
    "next": next,
  };
}

class Meta {
  Meta({
    this.currentPage,
    this.from,
    this.lastPage,
    this.links,
    this.path,
    this.perPage,
    this.to,
    this.total,
  });

  int? currentPage;
  int? from;
  int? lastPage;
  List<Link>? links;
  String? path;
  int? perPage;
  int? to;
  int? total;

  factory Meta.fromMap(Map<String, dynamic> json) => Meta(
    currentPage: json["current_page"],
    from: json["from"],
    lastPage: json["last_page"],
    links: List<Link>.from(json["links"].map((x) => Link.fromMap(x))),
    path: json["path"],
    perPage: json["per_page"],
    to: json["to"],
    total: json["total"],
  );

  Map<String, dynamic> toMap() => {
    "current_page": currentPage,
    "from": from,
    "last_page": lastPage,
    "links": List<dynamic>.from(links!.map((x) => x.toMap())),
    "path": path,
    "per_page": perPage,
    "to": to,
    "total": total,
  };
}

class Link {
  Link({
    this.url,
    this.label,
    this.active,
  });

  String? url;
  String? label;
  bool? active;

  factory Link.fromMap(Map<String, dynamic> json) => Link(
    url: json["url"] == null ? null : json["url"],
    label: json["label"],
    active: json["active"],
  );

  Map<String, dynamic> toMap() => {
    "url": url == null ? null : url,
    "label": label,
    "active": active,
  };
}

class EnumValues<T> {
  Map<String, T> map;
  late Map<T, String>? reverseMap;

  EnumValues(this.map);

  Map<T, String>? get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}