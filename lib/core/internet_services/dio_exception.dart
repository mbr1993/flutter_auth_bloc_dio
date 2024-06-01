import 'package:dio/dio.dart';

class DioErrors implements Exception {
  DioErrors(DioException dioException) {
    switch (dioException.type) {
      case DioExceptionType.cancel:
        errorMessage = 'Request to the server was cancelled.';
      case DioExceptionType.connectionTimeout:
        errorMessage = 'Connection timed out.';
      case DioExceptionType.receiveTimeout:
        errorMessage = 'Receiving timeout occurred.';
      case DioExceptionType.sendTimeout:
        errorMessage = 'Request send timeout.';
      case DioExceptionType.badResponse:
        errorMessage = _handleStatusCode(dioException.response?.statusCode);
      case DioExceptionType.unknown:
        if (dioException.message!.contains('SocketException')) {
          errorMessage = 'No Internet.';
          break;
        }
        errorMessage = 'Unexpected error occurred.';
      case DioExceptionType.badCertificate:
        errorMessage = 'Bad certificate.';
      case DioExceptionType.connectionError:
        errorMessage = 'Connection error.';
    }
  }

  late String errorMessage;

  String _handleStatusCode(int? statusCode) {
    switch (statusCode) {
      case 400:
        return 'User already exist ';
      case 401:
        return 'Authentication failed.';
      case 403:
        return 'The authenticated user is not allowed to access the specified API endpoint.';
      case 404:
        return 'The requested resource does not exist.';
      case 500:
        return 'Internal server error.';
      default:
        return 'Oops something went wrong!';
    }
  }

  @override
  String toString() => errorMessage;
}
