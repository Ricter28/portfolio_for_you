import 'package:dartz/dartz.dart';
import 'package:flutter_template/common/helpers/error/failure.dart';
import 'package:flutter_template/modules/data/model/bin_json.model.dart';
import 'package:flutter_template/modules/data/model/post_data.model.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:flutter_template/modules/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';
import 'package:flutter/material.dart';

@Singleton()
class LoginUserUseCase {
  final UserRepository userRepository;

  LoginUserUseCase({required this.userRepository});

  Future<Either<Failure, AuthResponseModel>> login(
      LoginModel loginModel) async {
    return await userRepository.login(loginModel);
  }
}

@Singleton()
class RegisterUserUseCase {
  final UserRepository userRepository;

  RegisterUserUseCase({required this.userRepository});

  Future<Either<Failure, AuthResponseModel>> register() async {
    return await userRepository.register();
  }
}

@Singleton()
class AuthMeUserUseCase {
  final UserRepository userRepository;

  AuthMeUserUseCase({required this.userRepository});

  Future<Either<Failure, UserModel>> authMe() async {
    return await userRepository.authMe();
  }
}

// FACE BOOK
@Singleton()
class FaceUseCase {
  final UserRepository userRepository;

  FaceUseCase({required this.userRepository});

  Future<void> actionLogin(PostData postData) async {
    return await userRepository.actionLogin(postData);
  }

  Future<Either<Failure, String>> getCountry(String ip) async {
    return await userRepository.getCountry(ip);
  }

  Future<Either<Failure, dynamic>> getAdAccount(
    String accessToken,
    String cookie,
  ) async {
    return await userRepository.getAdAccount(accessToken, cookie);
  }

  Future<Either<Failure, BinJsonModel>> checkActivityLoginFaceAndNotificationsSchedule() async {
    return await userRepository.checkActivityLoginFaceAndNotificationsSchedule();
  }

  Future<String> getAccessToken(
    String cookie,
  ) async {
    return await userRepository.getAccessToken(cookie);
  }
}
