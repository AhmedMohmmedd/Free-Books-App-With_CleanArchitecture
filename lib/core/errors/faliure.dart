import 'dart:io';
import 'package:dio/dio.dart';

abstract class Faliuer {
  final String errMassage;

  const Faliuer(this.errMassage);
}

class ServerFailure extends Faliuer {
  ServerFailure(super.errMassage);

  factory ServerFailure.fromDioError(DioError dioError) {
    switch (dioError.type) {
      case DioExceptionType.connectionTimeout:
        return ServerFailure('Connection time out');

      case DioExceptionType.sendTimeout:
        return ServerFailure('send timeout with ApiServer');
      case DioExceptionType.receiveTimeout:
        return ServerFailure('Receive timeout with ApiServer');

      case DioExceptionType.badCertificate:
        return ServerFailure('Connection badCertificate');
      case DioExceptionType.badResponse:
        return ServerFailure.fromResponse(
            dioError.response!.statusCode, dioError.response!.data);
      case DioExceptionType.cancel:
        return ServerFailure('send timeout with ApiServer was canceld');
      case DioExceptionType.connectionError:
        return ServerFailure('Connection error');
      case DioExceptionType.unknown:
        if (dioError.message!.contains('SocketException')) {
          return ServerFailure(' no internet connection');
        }
        return ServerFailure('Unexpected error ,try again');
      default:
        return ServerFailure('Opps there was an error, please try later');
    }
  }

  factory ServerFailure.fromResponse(int? statusCode, dynamic response) {
    if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
      return ServerFailure(response['error']['message']);
    } else if (statusCode == 404) {
      return ServerFailure('Your reqest not found , try later');
    } else if (statusCode == 500) {
      return ServerFailure('internat server error , try later');
    } else {
      return ServerFailure('Opps there was an error, please try later');
    }
  }
}









// // class Faliuer {}
// import 'package:dio/dio.dart';

// abstract class Faliuer {
//   final String message;

//   Faliuer(this.message);
// }

// class ServerFailure extends Faliuer {
//   ServerFailure(super.message);

//   factory ServerFailure.fromDiorError(DioError e) {
//     switch (e.type) {
//       case DioErrorType.connectionTimeout:
//         return ServerFailure('Connection timeout with api server');

//       case DioErrorType.sendTimeout:
//         return ServerFailure('Send timeout with ApiServer');
//       case DioErrorType.receiveTimeout:
//         return ServerFailure('Receive timeout with ApiServer');
//       case DioErrorType.badCertificate:
//         return ServerFailure('badCertificate with api server');
//       case DioErrorType.badResponse:
//         return ServerFailure.fromResponse(
//             e.response!.statusCode!, e.response!.data);
//       case DioErrorType.cancel:
//         return ServerFailure('Request to ApiServer was canceld');
//       case DioErrorType.connectionError:
//         return ServerFailure('No Internet Connection');
//       case DioErrorType.unknown:
//         return ServerFailure('Opps There was an Error, Please try again');
//     }
//   }

//   factory ServerFailure.fromResponse(int statusCode, dynamic response) {
//     if (statusCode == 404) {
//       return ServerFailure('Your request was not found, please try later');
//     } else if (statusCode == 500) {
//       return ServerFailure('There is a problem with server, please try later');
//     } else if (statusCode == 400 || statusCode == 401 || statusCode == 403) {
//       return ServerFailure(response['error']['message']);
//     } else {
//       return ServerFailure('There was an error , please try again');
//     }
//   }
// }





