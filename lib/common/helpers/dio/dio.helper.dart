import 'dart:developer';
import 'package:flutter_template/common/helpers/dio/token_manager.dart';
import 'package:injectable/injectable.dart';
import 'package:path/path.dart';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';

import 'package:flutter_template/common/helpers/dio/dio_interceptors.dart';
import 'package:flutter_template/common/utils/file.utils.dart';

class HttpResponse<T> {
  HttpResponse({
    this.body,
    this.headers,
    this.request,
    this.statusCode,
    this.statusMessage,
    this.extra,
  });

  T? body;
  Headers? headers;
  RequestOptions? request;
  int? statusCode;
  String? statusMessage;
  Map<String, dynamic>? extra;
}

@Singleton()
class DioHelper {
  static getDio() {
    Dio dio = Dio();
    TokenManager tokenManager = const TokenManager();
    if (!kIsWeb) {
      dio.interceptors.add(TokenInterceptor(dio, tokenManager));
    }
    return dio;
  }

  static Future<HttpResponse> get(String url, {Options? options}) async {
    log('REQUEST: GET => $url');

    final dio = DioHelper.getDio();
    final Response response = await dio.get(url, options: options);
    return HttpResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  static Future<HttpResponse> post(
      String url,
      Object data, {
        Options? options,
      }) async {
    log('REQUEST: POST => $url');

    final dio = DioHelper.getDio();
    final Response response = await dio.post(url, data: data, options: options);
    return HttpResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  static Future<HttpResponse> put(
      String url,
      Object data, {
        Options? options,
      }) async {
    log('REQUEST: PUT => $url');

    final dio = DioHelper.getDio();
    final Response response = await dio.put(url, data: data, options: options);
    return HttpResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  static Future<HttpResponse> delete(
      String url, {
        Options? options,
        Object? data,
      }) async {
    log('REQUEST: DELETE => $url');

    final dio = DioHelper.getDio();
    final Response response =
    await dio.delete(url, data: data, options: options);
    return HttpResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  static Future<HttpResponse> uploadFile(
      String url, {
        required File file,
        Options? options,
      }) async {
    log('REQUEST: UPLOAD FILE => $url');

    final dio = DioHelper.getDio();
    final uploadFile = await MultipartFile.fromFile(
      file.path,
      filename: basename(file.path),
    );
    final formData = FormData.fromMap({'file': uploadFile});
    final response = await dio.post(url, data: formData, options: options);
    return HttpResponse(
      body: response.data,
      headers: response.headers,
      request: response.request,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  static Future<HttpResponse> patch(
      String url, {
        FormData? formData,
        Object? data,
        Options? options,
      }) async {
    log('REQUEST: PATCH => $url');

    final dio = DioHelper.getDio();
    if (formData != null) data = formData;
    final Response response =
    await dio.patch(url, data: data, options: options);
    return HttpResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  static String? getUriQueryParam(Uri uri, String key) {
    final queryParams = uri.queryParametersAll.entries.toList();
    if (queryParams.any((_) => _.key == key)) {
      return queryParams.firstWhere((_) => _.key == key).value.first;
    }
    return null;
  }

  static Future<HttpResponse> postFormData(
      String url, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        Map<String, dynamic>? formData,
        Function(int count, int total)? onSendProgress,
      }) async {
    final Dio dio = DioHelper.getDio();
    if (formData != null) {
      data = await DioHelper.mapToFormData(formData);
    }
    final Response response = await dio.post(
      url,
      data: data,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
      options: options,
    );
    return HttpResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  static Future<HttpResponse> patchFormData(
      String url, {
        data,
        Map<String, dynamic>? queryParameters,
        Options? options,
        Map<String, dynamic>? formData,
        Function(int count, int total)? onSendProgress,
      }) async {
    final Dio dio = DioHelper.getDio();
    if (formData != null) {
      data = await DioHelper.mapToFormData(formData);
    }
    final Response response = await dio.patch(
      url,
      data: data,
      queryParameters: queryParameters,
      onSendProgress: onSendProgress,
      options: options,
    );
    return HttpResponse(
      body: response.data,
      headers: response.headers,
      request: response.requestOptions,
      statusCode: response.statusCode,
      statusMessage: response.statusMessage,
      extra: response.extra,
    );
  }

  static Future<FormData> mapToFormData(Map<String, dynamic> map) async {
    final formData = FormData.fromMap(map);
    final FormData newData = FormData();

    ///
    // ignore: avoid_function_literals_in_foreach_calls
    formData.fields.forEach((element) async {
      newData.fields.add(MapEntry(element.key, element.value));
    });

    ///
    // ignore: avoid_function_literals_in_foreach_calls
    formData.files.forEach((element) async {
      if (element.key.contains('[') || element.key.contains(']')) {
        final newKey =
        element.key.replaceAllMapped(RegExp('([+[a-zA-Z]+])'), (m) {
          return '${m[0]}'.replaceAll('[', '.').replaceAll(']', '');
        });
        final newValue = element.value;
        final newEntry = MapEntry(newKey, newValue);
        newData.files.add(newEntry);
      } else {
        newData.files.add(element);
      }
    });

    /// Check image
    final FormData res = FormData();
    int index = 0;
    int count = 0;
    for (var element in formData.fields) {
      if (element.key.contains('attachments')) {
        if (!element.key.contains('$index')) {
          count = 0;
          index++;
        }
        final String image = element.value;
        try {
          final mediaType = FileUtil.getMediaType(File(image));
          final uploadFile = await MultipartFile.fromFile(
            image,
            filename: basename(image),
            contentType: mediaType,
          );
          res.files.add(MapEntry('files', uploadFile));
          res.fields.add(MapEntry('${element.key}[$index]', basename(image)));
          count++;
        } catch (_) {
          res.fields.add(MapEntry('${element.key}[$index]', image));
          count++;
        }
        continue;
      }

      if (element.key.contains('images')) {
        if (!element.key.contains('$index')) {
          count = 0;
          index++;
        }
        final String image = element.value;
        try {
          final mediaType = FileUtil.getMediaType(File(image));
          final uploadFile = await MultipartFile.fromFile(
            image,
            filename: basename(image),
            contentType: mediaType,
          );
          res.files.add(MapEntry('files', uploadFile));
          res.fields.add(MapEntry('${element.key}[$count]', basename(image)));
          count++;
        } catch (_) {
          res.fields.add(MapEntry('${element.key}[$count]', image));
          count++;
        }
        continue;
      }

      if (element.key.contains('image')) {
        final String image = element.value;
        try {
          final mediaType = FileUtil.getMediaType(File(image));
          final uploadFile = await MultipartFile.fromFile(
            image,
            filename: basename(image),
            contentType: mediaType,
          );
          res.files.add(MapEntry('files', uploadFile));
          res.fields.add(MapEntry(element.key, basename(image)));
        } catch (_) {
          res.fields.add(MapEntry(element.key, element.value));
        }
      } else if (element.key.contains('brandIcon')) {
        final String image = element.value;
        try {
          final mediaType = FileUtil.getMediaType(File(image));
          final uploadFile = await MultipartFile.fromFile(
            image,
            filename: basename(image),
            contentType: mediaType,
          );
          res.files.add(MapEntry('file', uploadFile));
          res.fields.add(MapEntry(element.key, basename(image)));
        } catch (_) {
          res.fields.add(MapEntry(element.key, element.value));
        }
      } else {
        res.fields.add(element);
      }
    }
    return res;
  }
}
