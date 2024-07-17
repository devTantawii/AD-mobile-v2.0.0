
class OffersModel {
  String? message;
  int? discountValue;

  OffersModel({this.message, this.discountValue});

  OffersModel.fromJson(Map<String, dynamic> json) {
    message = json['message'];
    discountValue = json['discount_value'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['message'] = this.message;
  //   data['discount_value'] = this.discountValue;
  //   return data;
  // }
}