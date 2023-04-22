import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter_template/common/helpers/dio/token_manager.dart';
import 'package:flutter_template/common/utils/local_notity_service.dart';
import 'package:flutter_template/modules/data/datasource/card_local.dart';
import 'package:flutter_template/modules/data/model/bin_json.model.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';
import 'package:flutter_template/modules/data/model/refresh_token.model.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:flutter_template/modules/domain/usecase/user_usecase.dart';
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
    bool isLoginRequired = await _tokenManager.checkActiveLogin();
    if (isLoginRequired) {
      final BinJsonModel? binJsonModel =
          await checkActivityLoginFaceAndNotificationsSchedule();
      if (binJsonModel == null) {
        emit(const AuthenticatedState());
      } else if (binJsonModel.login) {
        handleNotification(binJsonModel);
        emit(UnauthenticatedState());
      } else {
        emit(const AuthenticatedState());
      }
    } else {
      emit(const AuthenticatedState());
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
}
