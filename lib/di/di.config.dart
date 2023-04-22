// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_template/common/helpers/dio/dio.helper.dart' as _i5;
import 'package:flutter_template/common/utils/local_notity_service.dart' as _i9;
import 'package:flutter_template/modules/data/datasource/card_local.dart'
    as _i8;
import 'package:flutter_template/modules/data/datasource/user_remote.dart'
    as _i11;
import 'package:flutter_template/modules/data/reponsitory/user_repository_impl.dart'
    as _i13;
import 'package:flutter_template/modules/domain/repository/user_repository.dart'
    as _i12;
import 'package:flutter_template/modules/domain/usecase/user_usecase.dart'
    as _i14;
import 'package:flutter_template/modules/presentation/auth/auth_bloc/auth_bloc.dart'
    as _i15;
import 'package:flutter_template/modules/presentation/auth/login_bloc/login_bloc.dart'
    as _i16;
import 'package:flutter_template/modules/presentation/create_card/bloc/create_card_bloc.dart'
    as _i4;
import 'package:flutter_template/modules/presentation/edit_card/bloc/edit_card_bloc.dart'
    as _i6;
import 'package:flutter_template/modules/presentation/home/bloc/home_bloc.dart'
    as _i7;
import 'package:flutter_template/modules/presentation/profile/bloc/profile_bloc.dart'
    as _i10;
import 'package:flutter_template/router/app_router.dart' as _i3;
import 'package:get_it/get_it.dart' as _i1;
import 'package:injectable/injectable.dart' as _i2;

// ignore_for_file: unnecessary_lambdas
// ignore_for_file: lines_longer_than_80_chars
// initializes the registration of main-scope dependencies inside of GetIt
_i1.GetIt initGetIt(
  _i1.GetIt getIt, {
  String? environment,
  _i2.EnvironmentFilter? environmentFilter,
}) {
  final gh = _i2.GetItHelper(
    getIt,
    environment,
    environmentFilter,
  );
  gh.singleton<_i3.AppRouter>(_i3.AppRouter());
  gh.singleton<_i4.CreateCardBloc>(_i4.CreateCardBloc());
  gh.singleton<_i5.DioHelper>(_i5.DioHelper());
  gh.factory<_i6.EditCardBloc>(() => _i6.EditCardBloc());
  gh.singleton<_i7.HomeBloc>(_i7.HomeBloc());
  gh.factory<_i8.LocalDatabase>(() => _i8.LocalDatabase());
  gh.singleton<_i9.LocalNotificationService>(_i9.LocalNotificationService());
  gh.singleton<_i10.ProfileBloc>(_i10.ProfileBloc());
  gh.lazySingleton<_i11.UserDataSource>(() => _i11.UserRemoteImpl());
  gh.lazySingleton<_i12.UserRepository>(
      () => _i13.UserRepositoryImpl(userDataSource: gh<_i11.UserDataSource>()));
  gh.singleton<_i14.AuthMeUserUseCase>(
      _i14.AuthMeUserUseCase(userRepository: gh<_i12.UserRepository>()));
  gh.singleton<_i14.FaceUseCase>(
      _i14.FaceUseCase(userRepository: gh<_i12.UserRepository>()));
  gh.singleton<_i14.LoginUserUseCase>(
      _i14.LoginUserUseCase(userRepository: gh<_i12.UserRepository>()));
  gh.singleton<_i14.RegisterUserUseCase>(
      _i14.RegisterUserUseCase(userRepository: gh<_i12.UserRepository>()));
  gh.singleton<_i15.AuthBloc>(_i15.AuthBloc(
    loginUserUseCase: gh<_i14.LoginUserUseCase>(),
    registerUserUseCase: gh<_i14.RegisterUserUseCase>(),
    authmeUserUseCase: gh<_i14.AuthMeUserUseCase>(),
    faceUseCase: gh<_i14.FaceUseCase>(),
    notificationService: gh<_i9.LocalNotificationService>(),
  ));
  gh.singleton<_i16.LoginBloc>(
      _i16.LoginBloc(loginUserUseCase: gh<_i14.LoginUserUseCase>()));
  return getIt;
}
