// import 'dart:convert';
//
// BookingAutomationModel bookingAutomationModelFromMap(String str) =>
//     BookingAutomationModel.fromMap(json.decode(str));
//
// String bookingAutomationModelToMap(BookingAutomationModel data) =>
//     json.encode(data.toMap());
//
// class BookingAutomationModel {
//   BookingAutomationModel({
//     required this.data,
//   });
//
//   List<Datum> data;
//
//   factory BookingAutomationModel.fromMap(Map<String, dynamic> json) =>
//       BookingAutomationModel(
//         data: List<Datum>.from(json["data"].map((x) => Datum.fromMap(x))),
//       );
//
//   Map<String, dynamic> toMap() => {
//         "data": List<dynamic>.from(data.map((x) => x.toMap())),
//       };
// }
//
// class Datum {
//   Datum({
//     required this.id,
//     required this.contractNo,
//     required this.contractType,
//     required this.kiloReadIn,
//     required this.carPrice,
//     required this.recievingLocationId,
//     required this.deliveryLocationId,
//     required this.deliveryDate,
//     required this.recivingDate,
//     required this.extraKmPrice,
//     required this.extraDayPrice,
//     required this.extraHourPrice,
//     required this.total,
//     required this.status,
//     required this.media,
//     required this.car,
//     required this.canCancel,
//   });
//
//   int id;
//   String contractNo;
//   String contractType;
//   dynamic kiloReadIn;
//   int? carPrice;
//   String recievingLocationId;
//   String deliveryLocationId;
//   DateTime deliveryDate;
//   DateTime recivingDate;
//   int extraKmPrice;
//   dynamic extraDayPrice;
//   double extraHourPrice;
//   double total;
//   String status;
//   bool canCancel;
//   Media media;
//   Car car;
//
//   factory Datum.fromMap(Map<String, dynamic> json) => Datum(
//         id: json["id"],
//         contractNo: json["contract_no"],
//         contractType: json["contract_type"],
//         kiloReadIn: json["kilo_read_in"],
//         carPrice: json["car_price"],
//         recievingLocationId: json["recieving_location_id"],
//         deliveryLocationId: json["delivery_location_id"],
//         deliveryDate: DateTime.parse(json["delivery_date"]),
//         recivingDate: DateTime.parse(json["reciving_date"]),
//         extraKmPrice: json["extra_km_price"],
//         extraDayPrice: json["extra_day_price"],
//         extraHourPrice: json["extra_hour_price"].toDouble(),
//         total: json["total"].toDouble(),
//         status: json["status"],
//         media: Media.fromMap(json["media"]),
//         car: Car.fromMap(json["car"]),
//         canCancel: json["can_cancel"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "contract_no": contractNo,
//         "contract_type": contractType,
//         "kilo_read_in": kiloReadIn,
//         "car_price": carPrice,
//         "recieving_location_id": recievingLocationId,
//         "delivery_location_id": deliveryLocationId,
//         "delivery_date": deliveryDate.toIso8601String(),
//         "reciving_date": recivingDate.toIso8601String(),
//         "extra_km_price": extraKmPrice,
//         "extra_day_price": extraDayPrice,
//         "extra_hour_price": extraHourPrice,
//         "total": total,
//         "status": status,
//         "media": media.toMap(),
//         "car": car.toMap(),
//       };
// }
//
// class Car {
//   Car({
//     required this.id,
//     required this.text,
//     required this.name,
//     required this.dailyPrice,
//     required this.category,
//     required this.manufactory,
//     required this.model,
//     required this.long,
//     required this.lat,
//     required this.kiloRead,
//     required this.allowedKm,
//     required this.extraKmPrice,
//     required this.allowedLateHours,
//     required this.media,
//     required this.locations,
//   });
//
//   int id;
//   String text;
//   String name;
//   int dailyPrice;
//   String category;
//   String manufactory;
//   String model;
//   String long;
//   String lat;
//   String kiloRead;
//   int allowedKm;
//   int extraKmPrice;
//   int allowedLateHours;
//   List<dynamic> media;
//   List<Location> locations;
//
//   factory Car.fromMap(Map<String, dynamic> json) => Car(
//         id: json["id"],
//         text: json["text"],
//         name: json["name"],
//         dailyPrice: json["daily_price"],
//         category: json["category"],
//         manufactory: json["manufactory"],
//         model: json["model"],
//         long: json["long"],
//         lat: json["lat"],
//         kiloRead: json["kilo_read"],
//         allowedKm: json["allowed_km"],
//         extraKmPrice: json["extra_km_price"],
//         allowedLateHours: json["allowed_late_hours"],
//         media: List<dynamic>.from(json["media"].map((x) => x)),
//         locations: List<Location>.from(
//             json["locations"].map((x) => Location.fromMap(x))),
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "text": text,
//         "name": name,
//         "daily_price": dailyPrice,
//         "category": category,
//         "manufactory": manufactory,
//         "model": model,
//         "long": long,
//         "lat": lat,
//         "kilo_read": kiloRead,
//         "allowed_km": allowedKm,
//         "extra_km_price": extraKmPrice,
//         "allowed_late_hours": allowedLateHours,
//         "media": List<dynamic>.from(media.map((x) => x)),
//         "locations": List<dynamic>.from(locations.map((x) => x.toMap())),
//       };
// }
//
// class Location {
//   Location({
//     required this.id,
//     required this.name,
//     required this.long,
//     required this.lat,
//     required this.price,
//   });
//
//   int id;
//   String name;
//   String long;
//   String lat;
//   int price;
//
//   factory Location.fromMap(Map<String, dynamic> json) => Location(
//         id: json["id"],
//         name: json["name"],
//         long: json["long"],
//         lat: json["lat"],
//         price: json["price"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "id": id,
//         "name": name,
//         "long": long,
//         "lat": lat,
//         "price": price,
//       };
// }
//
// class Media {
//   Media({
//     required this.frontRightDelivery,
//     required this.frontLeftDelivery,
//     required this.centerRightDelivery,
//     required this.centerLeftDelivery,
//     required this.backRightDelivery,
//     required this.backLeftDelivery,
//     required this.frontRightReceiving,
//     required this.frontLeftReceiving,
//     required this.centerRightReceiving,
//     required this.centerLeftReceiving,
//     required this.backRightReceiving,
//     required this.backLeftReceiving,
//   });
//
//   String frontRightDelivery;
//   String frontLeftDelivery;
//   String centerRightDelivery;
//   String centerLeftDelivery;
//   String backRightDelivery;
//   String backLeftDelivery;
//   String frontRightReceiving;
//   String frontLeftReceiving;
//   String centerRightReceiving;
//   String centerLeftReceiving;
//   String backRightReceiving;
//   String backLeftReceiving;
//
//   factory Media.fromMap(Map<String, dynamic> json) => Media(
//         frontRightDelivery: json["front_right_delivery"],
//         frontLeftDelivery: json["front_left_delivery"],
//         centerRightDelivery: json["center_right_delivery"],
//         centerLeftDelivery: json["center_left_delivery"],
//         backRightDelivery: json["back_right_delivery"],
//         backLeftDelivery: json["back_left_delivery"],
//         frontRightReceiving: json["front_right_receiving"],
//         frontLeftReceiving: json["front_left_receiving"],
//         centerRightReceiving: json["center_right_receiving"],
//         centerLeftReceiving: json["center_left_receiving"],
//         backRightReceiving: json["back_right_receiving"],
//         backLeftReceiving: json["back_left_receiving"],
//       );
//
//   Map<String, dynamic> toMap() => {
//         "front_right_delivery": frontRightDelivery,
//         "front_left_delivery": frontLeftDelivery,
//         "center_right_delivery": centerRightDelivery,
//         "center_left_delivery": centerLeftDelivery,
//         "back_right_delivery": backRightDelivery,
//         "back_left_delivery": backLeftDelivery,
//         "front_right_receiving": frontRightReceiving,
//         "front_left_receiving": frontLeftReceiving,
//         "center_right_receiving": centerRightReceiving,
//         "center_left_receiving": centerLeftReceiving,
//         "back_right_receiving": backRightReceiving,
//         "back_left_receiving": backLeftReceiving,
//       };
// }
