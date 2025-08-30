import 'dart:async';
import 'package:dio/dio.dart';
import '../../../../core/utils/enums.dart';
import 'urls.dart';

class BaseService {
  static BaseService instance = BaseService._internal();
  final Dio dio = Dio();

  BaseService._internal() {
    // dio.interceptors.add(RequestBypassInterceptor());
  }

  Future<dynamic> makeRequest<T>(
      {required String url,
      String? baseUrl,
      dynamic body,
      String? contentType,
      Map<String, dynamic>? queryParameters,
      Map<String, String>? headers,
      RequestType method = RequestType.get,
      Map<String, dynamic> extras = const {},
      bool isOfflineApi = true,
      bool isFromQueue = false}) async {
    dio.options.baseUrl = baseUrl ?? Urls.baseUrl;
    dio.options.extra.addAll(extras);

    if (headers != null) dio.options.headers.addAll(headers);

    Response response;
    switch (method) {
      case RequestType.get:
        if (queryParameters != null && queryParameters.isNotEmpty) {
          response = await dio.get(url, queryParameters: queryParameters);
          return response.data;
        }
        response = await dio.get(url);
        return response.data;
      case RequestType.put:
        response =
            await dio.put(url, queryParameters: queryParameters, data: body);
        return response.data;
      case RequestType.post:
        response =
            await dio.post(url, queryParameters: queryParameters, data: body);
        return response.data;
      case RequestType.delete:
        response =
            await dio.delete(url, queryParameters: queryParameters, data: body);
        return response.data;
    }
  }
}
