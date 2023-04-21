import 'package:dartz/dartz.dart';
import 'package:flutter_template/common/helpers/error/failure.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';

abstract class UserRepository {
  Future<Either<Failure, AuthResponseModel>> login(LoginModel loginModel);
  Future<Either<Failure, AuthResponseModel>> register();
  Future<Either<Failure, UserModel>> authMe();
}
