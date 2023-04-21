import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/constants/keys/hive_keys.dart';
import 'package:flutter_template/common/helpers/error/hive/hive.helper.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/modules/data/datasource/card_local.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';
import 'package:flutter_template/modules/data/model/item.model.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:injectable/injectable.dart';

part 'home_event.dart';
part 'home_state.dart';

@Singleton()
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final LocalDatabase localDatabase = LocalDatabase();

  HomeBloc() : super(InitHomeState()) {
    on<InitHomeEvent>(_onIntiHomeState);
    on<DeleteCardEvent>(_onDeleteCardState);
    on<AddToSpotlightEvent>(_onAddtoSpotlightState);
    on<RemoveFromSpotlightEvent>(_onRemoveFromSpotlightState);
    on<SearchEvent>(_onSearchState);
  }

  Future<void> _onSearchState(
    SearchEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const LoadingHomeState());
    await Future.delayed(const Duration(seconds: 1));
    List<CardModel> cards = await localDatabase.getCards();
    List<ItemModel> items = await localDatabase.getItems();
    List<CardModel> result = [];
    for (var element in cards) {
      List<ItemModel> i = [];
      if (event.keywork.isNotEmpty) {
        if (element.name!.contains(event.keywork)) {
          print(element.name!.contains(event.keywork));
          for (var ie in items) {
            if (ie.cardId == element.id) {
              i.add(ie);
            }
          }
          element.items = i;
          result.add(element);
        }
      }else{
        for (var ie in items) {
            if (ie.cardId == element.id) {
              i.add(ie);
            }
          }
          element.items = i;
          result.add(element);
      }
    }
    final user = await getUserProfile();
    emit(LoadedHomeState(user, result));
  }

  Future<void> _onAddtoSpotlightState(
    AddToSpotlightEvent event,
    Emitter<HomeState> emit,
  ) async {
    event.cardModel.isSpotlight = '1';
    await localDatabase.updateCard(event.cardModel);
  }

  Future<void> _onRemoveFromSpotlightState(
    RemoveFromSpotlightEvent event,
    Emitter<HomeState> emit,
  ) async {
    event.cardModel.isSpotlight = '0';
    await localDatabase.updateCard(event.cardModel);
    getIt<HomeBloc>().add(const InitHomeEvent());
  }

  Future<void> _onDeleteCardState(
    DeleteCardEvent event,
    Emitter<HomeState> emit,
  ) async {
    await localDatabase.deleteCard(event.cardModel.id ?? 0);
    event.cardModel.items!.forEach((element) async {
      await localDatabase.deleteItem(element.id ?? 0);
    });
    getIt<HomeBloc>().add(const InitHomeEvent());
  }

  FutureOr<void> _onIntiHomeState(
    InitHomeEvent event,
    Emitter<HomeState> emit,
  ) async {
    emit(const LoadingHomeState());
    await Future.delayed(const Duration(seconds: 1));
    List<CardModel> cards = await localDatabase.getCards();
    List<ItemModel> items = await localDatabase.getItems();
    List<CardModel> result = [];
    for (var element in cards) {
      List<ItemModel> i = [];
      for (var ie in items) {
        if (ie.cardId == element.id) {
          i.add(ie);
        }
      }
      element.items = i;
      result.add(element);
    }
    final user = await getUserProfile();
    emit(LoadedHomeState(user, result));
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
}
