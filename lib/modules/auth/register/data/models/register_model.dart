import 'dart:convert';
import 'dart:io';

class RegisterModel {
  String? name;
  String? email;
  String? phone;
  String? password;
  String? passwordConfirm;
  String? id;
  File? identityFace;
  File? identityBack;
  File? licenceFace;
  File? licenceBack;

  RegisterModel({
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
    required this.passwordConfirm,
    this.id,
    this.identityFace,
    this.identityBack,
    this.licenceFace,
    this.licenceBack,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
      'password_confirmation': passwordConfirm,
      'licenceFace': licenceFace!.path.toString(),
    };
  }

  String toJson() => json.encode(toMap());
}
