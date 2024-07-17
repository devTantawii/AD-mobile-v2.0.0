import 'dart:convert';

class SignInModel {
  String ?email;
  String? password;
  String? custClass;
  String? device_token;
  //String custClass;
  SignInModel({
    required this.email,
    required this.password,
    this.device_token,
    String? custClass
  });
  SignInModel.fromJson(Map<String, dynamic> json) {
    custClass = json['cust_class'];
    device_token = json['device_token'];
    // custClass = json['email'];
    // custClass = json['password'];
  }
  Map<String, dynamic> toMap() {
    return {
      'username': email,
      'password': password,
      'device_token': device_token,
    };
  }

  String toJson() => json.encode(toMap());
}
