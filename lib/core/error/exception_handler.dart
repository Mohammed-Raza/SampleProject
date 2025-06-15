import 'dart:io';
import 'package:dio/dio.dart';
import 'package:toastification/toastification.dart';
import '../../generated/assets.dart';
import '../mixins/notifier_mixin.dart';
import '../utils/enums.dart';
import '../utils/records_typedefs.dart';

class ExceptionHandler {
  static final ExceptionHandler _singleton = ExceptionHandler._internal();

  factory ExceptionHandler() {
    return _singleton;
  }

  ExceptionHandler._internal();

  /// Handle exception with toast message
  void handleExceptionWithToastNotifier(Object exception,
      {StackTrace? stackTrace, String? toastMessage}) {
    ErrorDetails errorStateType = handleException(exception, stackTrace);
    late String notifierText;
    var statusCode = (exception as dynamic).response?.statusCode;
    switch (errorStateType.$1) {
      case DataErrorStateType.noInternet:
        notifierText = 'Check your Internet connection!!!';
      case DataErrorStateType.serverNotFound:
        notifierText = '$statusCode : Unable to connect the Server!!!';
      case DataErrorStateType.somethingWentWrong:
        notifierText = 'Something went wrong !!';
      case DataErrorStateType.badRequest:
        notifierText = '$statusCode :  Unknown Exception occurred!!!';
      case DataErrorStateType.unauthorized:
        notifierText = '$statusCode : Not Authorized!!!';
      case DataErrorStateType.timeoutException:
        notifierText = 'Timeout Exception!!!';
      case DataErrorStateType.pageNotFound:
        notifierText = '$statusCode : Page not found error';
      case DataErrorStateType.none:
        notifierText = toastMessage ?? 'Unknown Exception occurred!!!';
    }

    ToastNotifier.showNewToast('Error occurred', notifierText,
        type: ToastificationType.error);
  }

  /// Method is to get exception string as return type
  String getErrorTextBasedOnType(Object exception, {StackTrace? stackTrace}) {
    ErrorDetails errorStateType = handleException(exception, stackTrace);
    var statusCode = (exception as dynamic).response?.statusCode;
    switch (errorStateType.$1) {
      case DataErrorStateType.noInternet:
        return 'Check your internet connection';
      case DataErrorStateType.timeoutException:
        return 'Timeout Exception !!!';
      case DataErrorStateType.serverNotFound:
        return '$statusCode : Unable to connect server';
      case DataErrorStateType.somethingWentWrong:
        return 'Something went wrong !!';
      case DataErrorStateType.badRequest:
        return '$statusCode : Bad request';
      case DataErrorStateType.unauthorized:
        return '$statusCode : Not Authorized!!!';
      case DataErrorStateType.pageNotFound:
        return '$statusCode : Check your internet connection';
      case DataErrorStateType.none:
        return 'Unknown exception occurred';
    }
  }

  /// Method is to get exception path & text for page error as return type
  (String, String) getPageErrorDetails(Object exception,
      {StackTrace? stackTrace}) {
    ErrorDetails errorStateType = handleException(exception, stackTrace);
    switch (errorStateType.$1) {
      case DataErrorStateType.noInternet:
        return ('Check your internet connection', Assets.gifsNoInternet);
      case DataErrorStateType.timeoutException:
        return ('Timeout Exception !!!', Assets.gifsPageError);
      case DataErrorStateType.serverNotFound:
        return ('Internal server error', Assets.gifs500);
      case DataErrorStateType.somethingWentWrong:
        return ('Something went wrong', Assets.gifsPageError);
      case DataErrorStateType.badRequest:
        return ('Bad request', Assets.gifs400);
      case DataErrorStateType.unauthorized:
        return ("Unauthorized, You don't have access", Assets.gifs401);
      case DataErrorStateType.pageNotFound:
        return ('Page not found', Assets.gifs404);
      case DataErrorStateType.none:
        return ("Don't worry, team is working on it", Assets.gifsPageError);
    }
  }

  ErrorDetails handleException(Object exception, [StackTrace? stackTrace]) {
    ErrorDetails errorStateType = (DataErrorStateType.none, message: null);

    if (exception is DioException) {
      errorStateType = handleServerException(exception, stackTrace);
    } else {}

    return errorStateType;
  }

  ErrorDetails handleServerException(
      DioException exception, StackTrace? stackTrace) {
    var errorStateType = DataErrorStateType.none;
    String? message;

    switch (exception.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
        errorStateType = DataErrorStateType.timeoutException;
        break;
      case DioExceptionType.connectionError:
        errorStateType = DataErrorStateType.noInternet;
        break;
      case DioExceptionType.badResponse:
        switch (exception.response?.statusCode) {
          case 400:
          case 405:
            errorStateType = DataErrorStateType.badRequest;
            break;
          case 401:
          case 403:
            errorStateType = DataErrorStateType.unauthorized;
            break;
          case 404:
            errorStateType = DataErrorStateType.pageNotFound;
            break;
          case 500:
          case 502:
            errorStateType = DataErrorStateType.serverNotFound;
            break;
        }
      case DioExceptionType.unknown:
        errorStateType = DataErrorStateType.somethingWentWrong;
      default:
    }
    return (errorStateType, message: message);
  }

  DataErrorStateType handleNetworkExceptions(
      Exception exception, StackTrace? stackTrace) {
    var errorStateType = DataErrorStateType.none;

    switch (exception.runtimeType) {
      case SocketException _:
        errorStateType = DataErrorStateType.noInternet;
        break;
      default:
    }
    return errorStateType;
  }

  void handleErrors() {}
}
