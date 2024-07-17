import 'dart:convert';

class Encoder {
  static String toBase64Encode(List<int> fileAsBytes) => base64.encode(fileAsBytes);
}
