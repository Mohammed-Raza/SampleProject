import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sample_project/core/error/exception_handler.dart';
import 'package:sample_project/core/utils/enums.dart';

void main() {
  group('ExceptionHandler Tests', () {
    final exceptionHandler = ExceptionHandler();

    test('should return noInternet for connectionError', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.connectionError,
      );

      final result = exceptionHandler.handleServerException(exception, null);

      expect(result.$1, DataErrorStateType.noInternet);
    });

    test('should return unauthorized for 401 status code', () {
      final exception = DioException(
        requestOptions: RequestOptions(path: ''),
        type: DioExceptionType.badResponse,
        response: Response(
          requestOptions: RequestOptions(path: ''),
          statusCode: 401,
        ),
      );

      final result = exceptionHandler.handleServerException(exception, null);

      expect(result.$1, DataErrorStateType.unauthorized);
    });
  });
}
