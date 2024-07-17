import 'package:dio/dio.dart';

///Generic exception to catch and handle resulted error.
class AppException implements Exception {
  final message;
  final details;
  final data;

  const AppException([this.message, this.details, this.data]);

  @override
  String toString() => "message: $message -> Details: $details";
}

class FetchDataException extends AppException {
  const FetchDataException({required String details, data})
      : super("Error During Communication.", details, data);
}

class BadRequestException extends AppException {
  const BadRequestException([details]) : super("Invalid Request.", details);
}

class UnProcessableEntity extends AppException {
  const UnProcessableEntity(message, {required Map<String, dynamic> details})
      : super(message, details);
}

class UnAuthenticatedException extends AppException {
  const UnAuthenticatedException([details]) : super("Unauthorised.", details);
}

class EmailNotFoundException extends AppException {
  const EmailNotFoundException({required String message}) : super(message);

  @override
  String toString() => 'EmailNotFoundException (message: $message)';
}

class ResetPasswordCodeNotValidException extends AppException {
  const ResetPasswordCodeNotValidException(
    String message,
  ) : super(message);

  @override
  String toString() => ' ResetPasswordCodeNotValidExeption(message: $message)';
}

///A Firebase auth exception indicates that the used email is invalid or can't be used.
///
///See also:
///- `isValidEmail(String)`
///
class EmailAlreadyUsedException extends AppException {
  const EmailAlreadyUsedException(
    String message,
  ) : super(message);

  @override
  String toString() => 'EmailAlreadyUsedException(message: $message)';
}

///Throw when the developer asks for [PreferenceUtils] method before initialized the [SharedPreferences] package instance.
class PreferenceUtilsNotInitializedException extends AppException {
  const PreferenceUtilsNotInitializedException(
    String message,
  ) : super(message);
}

///Throw when you try to save unsupported DataType into [SharedPreferences]
class NotSupportedTypeToSaveException extends AppException {}

class NotFoundRouteException extends AppException {}

/////////////////////////////////

class Failure implements Exception {
  late String message;

  @override
  String toString() => message;

  Failure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioErrorType.cancel:
        message = "Request to API server was cancelled";
        break;
      case DioErrorType.connectTimeout:
        message = "Connection timeout with server";
        break;
      case DioErrorType.receiveTimeout:
        message = "Receive timeout in connection with server";
        break;
      case DioErrorType.sendTimeout:
        message = "Send timeout in connection with server";
        break;
      case DioErrorType.other:
        message = "Connection failed due to internet connection";
        break;
      case DioErrorType.response:
        message = handleError(dioError);
        break;
      default:
        message = "Something went wrong";
        break;
    }
  }

  String handleError(DioError dioError) {
    final statusCodeMessages  ={
      500: "Server Error",
      401: "Not Authenticated",
      422: "Data is not valid",
      404: "Data Not Found",
      429: "Too many requests",
      403:"Your Request Is Not Allowed",
    };
    String message = statusCodeMessages[dioError.response!.statusCode] ?? dioError.message;
    // String message = "";
    // switch (dioError.response!.statusCode) {
    //   case 500:
    //     message = "Server Error";
    //     break;
    //   case 401:
    //     message = "Not Authenticated";
    //     break;
    //   case 422:
    //     message = "Data is not valid";
    //     break;
    //   case 404:
    //     message = "Data Not Found";
    //     break;
    //   case 429:
    //     message = "Too many requests";
    //     break;
    //   case 403:
    //     message = "Your Request Is Not Allowed";
    //     break;
    //   default:
    //     message = dioError.message;
    //     break;
    // }
    return message;
  }
// String _handleError(DioError dioError) {
//   final Map<String, dynamic>? response = json.decode(
//     dioError.response!.data.toString(),
//   ) as Map<String, dynamic>;
//
//   return response?.entries.?first?.value[0].toString() ?? "error";
// }
}
