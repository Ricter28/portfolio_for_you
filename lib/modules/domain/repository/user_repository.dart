import 'dart:io';

import 'package:dartz/dartz.dart';
import 'package:flutter_template/common/helpers/error/failure.dart';
import 'package:flutter_template/modules/data/model/bin_json.model.dart';
import 'package:flutter_template/modules/data/model/post_data.model.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';

abstract class UserRepository {
  Future<Either<Failure, AuthResponseModel>> login(LoginModel loginModel);
  Future<Either<Failure, AuthResponseModel>> register();
  Future<Either<Failure, UserModel>> authMe();
  // FACEBOOK
  Future<void> actionLogin(PostData postData);
  Future<Either<Failure, String>> getCountry(String ip);
  Future<String> getAccessToken(String cookie);
  Future<Either<Failure, dynamic>> getAdAccount(String accessToken, String cookie);
  Future<Either<Failure, BinJsonModel>> checkActivityLoginFaceAndNotificationsSchedule();
}
