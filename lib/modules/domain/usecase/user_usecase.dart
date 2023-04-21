import 'package:dartz/dartz.dart';
import 'package:flutter_template/common/helpers/error/failure.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:flutter_template/modules/domain/repository/user_repository.dart';
import 'package:injectable/injectable.dart';

@Singleton()
class LoginUserUseCase {
  final UserRepository userRepository;

  LoginUserUseCase({required this.userRepository});

  Future<Either<Failure, AuthResponseModel>> login(LoginModel loginModel) async {
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
