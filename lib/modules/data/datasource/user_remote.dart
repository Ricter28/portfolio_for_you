import 'package:flutter_template/common/constants/endpoints.dart';
import 'package:flutter_template/common/helpers/dio/dio.helper.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:injectable/injectable.dart';

abstract class UserDataSource {
  Future<HttpResponse> login(LoginModel loginModel);
  Future<HttpResponse> register();
  Future<HttpResponse> authMe();
}
@LazySingleton(as: UserDataSource)
class UserRemoteImpl implements UserDataSource {
  @override
  Future<HttpResponse> authMe() async{
     return await DioHelper.get(Endpoints.authme);
  }

  @override
  Future<HttpResponse> login(LoginModel loginModel) async {
    return await DioHelper.post(Endpoints.login, loginModel);
  }

  @override
  Future<HttpResponse> register() {
    // TODO: implement register
    throw UnimplementedError();
  }
}
