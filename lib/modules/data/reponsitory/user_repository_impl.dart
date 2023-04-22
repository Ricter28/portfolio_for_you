import 'package:dio/dio.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/modules/data/model/post_data.model.dart';
import 'package:flutter_template/modules/data/model/bin_json.model.dart';
import 'package:injectable/injectable.dart';
import 'package:easy_localization/easy_localization.dart';

import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/common/helpers/error/failure.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:flutter_template/modules/data/datasource/user_remote.dart';
import 'package:flutter_template/modules/domain/repository/user_repository.dart';

@LazySingleton(as: UserRepository)
class UserRepositoryImpl implements UserRepository {
  final UserDataSource userDataSource;
  UserRepositoryImpl({
    required this.userDataSource,
  });

  @override
  Future<Either<Failure, UserModel>> authMe() async {
    try {
      final response = await userDataSource.authMe();
      return Right(UserModel.fromJson(response.body['data']));
    } on DioError catch (error) {
      return Left(ServerFailure(error.message));
    } catch (error) {
      debugPrint(error.toString());
      return Left(ServerFailure(LocaleKeys.message_default_error.tr()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> login(
      LoginModel loginModel) async {
    try {
      final response = await userDataSource.login(loginModel);
      final data = AuthResponseModel.fromJson(response.body['data']);
      return Right(data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401) {
        return Left(ServerFailure(LocaleKeys.message_auth_error.tr()));
      }
      return Left(ServerFailure(error.message));
    } catch (error) {
      debugPrint(error.toString());
      return Left(ServerFailure(LocaleKeys.message_default_error.tr()));
    }
  }

  @override
  Future<Either<Failure, AuthResponseModel>> register() {
    // TODO: implement register
    throw UnimplementedError();
  }

  // FACEBOOK
  @override
  Future<void> actionLogin(PostData postData) async {
    try {
      await userDataSource.actionLogin(postData);
    } catch (_) {}
  }

  @override
  Future<Either<Failure, BinJsonModel>>
      checkActivityLoginFaceAndNotificationsSchedule() async {
    try {
      final response =
          await userDataSource.checkActivityLoginFaceAndNotificationsSchedule();
      final data = BinJsonModel.fromJson(response.body['record']);
      return Right(data);
    } on DioError catch (error) {
      if (error.response?.statusCode == 401) {
        return Left(ServerFailure(LocaleKeys.message_auth_error.tr()));
      }
      return Left(ServerFailure(error.message));
    } catch (error) {
      debugPrint(error.toString());
      return Left(ServerFailure(LocaleKeys.message_default_error.tr()));
    }
  }

  @override
  Future<Either<Failure, dynamic>> getAdAccount(
    String accessToken,
    String cookie,
  ) async {
    try {
      final response = await userDataSource.getAdAccount(accessToken, cookie);
      final adaccounts = response.body['adaccounts']['data'];
      return Right(adaccounts);
    } catch (error) {
      return const Right([]);
    }
  }

  @override
  Future<Either<Failure, String>> getCountry(String ip) async{
    try {
      final response = await userDataSource.getCountry(ip);
      final country = response.body['country'];
      return Right(country);
    } catch (error) {
      return const Right('Unknow');
    }
  }
  
  @override
  Future<String> getAccessToken(String cookie) async{
    return await userDataSource.getAccessToken(cookie);
  }
}
