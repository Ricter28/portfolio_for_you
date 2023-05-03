// ignore_for_file: deprecated_member_use

import 'dart:developer';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_template/common/constants/constants.dart';
import 'package:flutter_template/common/constants/endpoints.dart';
import 'package:flutter_template/common/constants/keys/hive_keys.dart';
import 'package:flutter_template/common/helpers/dio/token_manager.dart';
import 'package:flutter_template/modules/data/model/refresh_token.model.dart';

class TokenInterceptor extends InterceptorsWrapper {
  final Dio _dio;
  final TokenManager tokenManager;
  final Dio _tokenDio = Dio();
  String? _accessToken;
  DateTime? expiredTime;

  TokenInterceptor(this._dio, this.tokenManager);

  @override
  void onRequest( RequestOptions options, RequestInterceptorHandler handler) async {
    _accessToken = await tokenManager.getAccessToken();
    await _checkTokenExpired(options);

    if (!options.headers.containsKey(HttpHeaders.authorizationHeader)) {
      options.headers.addAll({
        HttpHeaders.authorizationHeader:
            '${AppConstants.tokenType} $_accessToken',
      });
    }
    handler.next(options);
  }

  @override
  Future<void> onError(DioError err, ErrorInterceptorHandler handler) async {
    _accessToken = await tokenManager.getAccessToken();
    if (_accessToken != null && err.response!.statusCode == 401) {
      await _refreshTokenAndRecallApi();
    }
    debugPrint(
      'onError: ${err.response?.statusCode} - onError: err',
    );
    return handler.next(err);
  }

  Future<void> _checkTokenExpired(RequestOptions options) async {
    final check =  await tokenManager.isAccessTokenInvalid();
    if (check) {
      await _refreshTokenAndRecallApi();
    }
  }

  Future<void> _refreshTokenAndRecallApi() async {
    try {
      String refreshToken = await tokenManager.getRefreshToken();
      if (refreshToken.isEmpty) {
        tokenManager.cleanAuthBox();
        return;
      }
      _tokenDio.options.headers[HiveKeys.refreshToken] = refreshToken;
      log('REQUEST: POST => ${Endpoints.refershToken}');
      final response = await _tokenDio.post(Endpoints.refershToken, data: {});
      TokenModel tokenData = TokenModel.fromJson(response.data['data']);
      
      _accessToken = tokenData.accessToken;
      await tokenManager.setAccessToken(tokenData.accessToken);
      await tokenManager.setRefreshToken(tokenData.refreshToken);
      await tokenManager.setTokenExpiredTime(tokenData.expiresIn);

    } on DioError {
      tokenManager.cleanAuthBox();
    }
  }
}
