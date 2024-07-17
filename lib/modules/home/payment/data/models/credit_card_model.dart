class CreditCardModel {
  String? orderId;
  String? nameOnCard;
  String? cardNumber;
  dynamic expiryMonth;
  dynamic expiryYear;
  int? securityCode;
  String? paymentType;
  String? couponCode;

  CreditCardModel({
    this.orderId,
    this.nameOnCard,
    this.cardNumber,
    this.expiryMonth,
    this.expiryYear,
    this.securityCode,
    this.paymentType,
    this.couponCode,
  });

  factory CreditCardModel.fromJson(Map<String, dynamic> json) =>
      CreditCardModel(
        orderId: json["order_id"],
        paymentType: json["payment_type"],
        nameOnCard: json["nameOnCard"],
        cardNumber: json["CardNumber"],
        expiryMonth: json["expiry_month"],
        expiryYear: json["expiry_year"],
        securityCode: json["securityCode"],
      );

  Map<String, dynamic> toJson() {
    final json;
    switch (paymentType) {
      case "visa":
        json = toVisaJson();
        break;
      case "بطاقة إئتمان":
        json = toVisaJson();
        break;
      case "cash":
        json = toCashJson();
        break;
      case "نقدي":
        json = toCashJson();
        break;
      case "points":
        json = toPointsJson();
        break;
      case "نقاط":
        json = toPointsJson();
        break;
      default:
        json = toCashJson();
        break;
    }
    return json;
  }

  Map<String, dynamic> toVisaJson() => {
        "order_id": orderId,
        "payment_type": "visa",
        "nameOnCard": nameOnCard,
        "CardNumber": cardNumber,
        "expiry_month": expiryMonth,
        "expiry_year": expiryYear,
        "securityCode": securityCode,
        "coupon": couponCode,
      };

  Map<String, dynamic> toCashJson() => {
        "order_id": orderId,
        "payment_type": "cash",
        "coupon": couponCode,
      };

  Map<String, dynamic> toPointsJson() => {
        "order_id": orderId,
        "payment_type": "points",
        "coupon": couponCode,
      };
}
