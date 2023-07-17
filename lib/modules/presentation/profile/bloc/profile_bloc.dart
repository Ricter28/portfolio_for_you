import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/constants/keys/hive_keys.dart';
import 'package:flutter_template/common/helpers/error/hive/hive.helper.dart';
import 'package:flutter_template/common/utils/dialog.util.dart';
import 'package:flutter_template/common/widgets/image_picker.widget.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:flutter_template/modules/presentation/home/bloc/home_bloc.dart';
import 'package:injectable/injectable.dart';

part 'profile_event.dart';
part 'profile_state.dart';

@Singleton()
class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileBloc() : super(InitProfileState()) {
    on<InitProfileEvent>(_onIntiProfileState);
    on<ChooseAvatarProfileEvent>(_onChooseAvatarState);
    on<UpdateProfileEvent>(_onUpdateProfileState);
  }

  FutureOr<void> _onIntiProfileState(
    InitProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    emit(const LoadingProfileState());
    await HiveHelper.openBox(HiveKeys.authBox);
    await Future.delayed(const Duration(seconds: 1));
    final user = await getUserProfile();
    emit(LoadedProfileState(user));
  }

  Future _onUpdateProfileState(
    UpdateProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    if (event.newUser.avatar!.isEmpty &&
        event.newUser.name!.isEmpty &&
        event.newUser.email!.isEmpty &&
        event.newUser.phone!.isEmpty) {
      final user = await getUserProfile();
      emit(LoadedProfileState(user));
    } else {
      DialogUtil.showLoading(event.context);
      await Future.delayed(const Duration(seconds: 1));
      await updateUserProfile(event.newUser)
          .then((value) => DialogUtil.hideLoading(event.context));
      getIt<HomeBloc>().add(const InitHomeEvent());
      emit(LoadedProfileState(event.newUser));
    }
  }

  FutureOr<void> _onChooseAvatarState(
    ChooseAvatarProfileEvent event,
    Emitter<ProfileState> emit,
  ) async {
    File? imagePicked = await updateAvatar(event.context);
    if (imagePicked == null) {
      emit(const ChooseAvatarProfileState(''));
    } else {
      emit(ChooseAvatarProfileState(imagePicked.path));
    }
  }

  Future<File?> updateAvatar(BuildContext context) async {
    try {
      return await CustomImagePicker.appBottomSheet(context);
    } catch (e) {
      return null;
    }
  }

  Future<UserModel> getUserProfile() async {
    String? avatar = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.userAvatar,
    );
    String? name = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.userName,
    );
    String? email = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.userEmail,
    );
    String? phone = await HiveHelper.get(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.userPhone,
    );
    return UserModel(
      avatar: avatar,
      name: name,
      email: email,
      phone: phone,
    );
  }

  Future<UserModel> updateUserProfile(UserModel newUser) async {
    await HiveHelper.put(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.userAvatar,
      value: newUser.avatar,
    );
    await HiveHelper.put(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.userName,
      value: newUser.name,
    );
    await HiveHelper.put(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.userEmail,
      value: newUser.email,
    );
    await HiveHelper.put(
      boxName: HiveKeys.authBox,
      keyValue: HiveKeys.userPhone,
      value: newUser.phone,
    );
    return newUser;
  }
}
