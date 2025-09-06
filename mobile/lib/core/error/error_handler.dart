import 'package:dio/dio.dart';
import 'exceptions.dart';
import 'failures.dart';

class ErrorHandler {
  static Failure handleError(dynamic error) {
    if (error is DioException) {
      return _handleDioError(error);
    } else if (error is ServerException) {
      return ServerFailure(message: error.message);
    } else if (error is CacheException) {
      return CacheFailure(message: error.message);
    } else if (error is NetworkException) {
      return NetworkFailure(message: error.message);
    } else if (error is ValidationException) {
      return ValidationFailure(message: error.message);
    } else if (error is AuthenticationException) {
      return AuthenticationFailure(message: error.message);
    } else {
      return UnknownFailure(message: error.toString());
    }
  }

  static Failure _handleDioError(DioException error) {
    switch (error.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
        return const NetworkFailure(
            message:
                'Connection timeout. Please check your internet connection.');

      case DioExceptionType.badResponse:
        final statusCode = error.response?.statusCode;
        final message =
            error.response?.data?['message'] ?? 'Server error occurred.';

        if (statusCode == 401) {
          return AuthenticationFailure(message: message);
        } else if (statusCode == 422) {
          return ValidationFailure(message: message);
        } else {
          return ServerFailure(message: 'Error $statusCode: $message');
        }

      case DioExceptionType.cancel:
        return const NetworkFailure(message: 'Request was cancelled.');

      case DioExceptionType.connectionError:
        return const NetworkFailure(
            message: 'No internet connection. Please check your network.');

      default:
        return UnknownFailure(
            message: error.message ?? 'An unexpected error occurred.');
    }
  }
}
