import 'dart:async';
import 'dart:io';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/widgets/image_picker.widget.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/modules/data/datasource/card_local.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';
import 'package:flutter_template/modules/presentation/home/bloc/home_bloc.dart';
import 'package:injectable/injectable.dart';

part 'create_card_event.dart';
part 'create_card_state.dart';

@Singleton()
class CreateCardBloc extends Bloc<CreateCardEvent, CreateCardState> {
  final LocalDatabase localDatabase = LocalDatabase();
  CreateCardBloc() : super(const InitCreateCardState()) {
    on<InitCreateCardEvent>(_onInitState);
    on<ChooseImageEvent>(_onChooseImageState);
    on<CreateCreateCardEvent>(_onCreateCardEvent);
  }

  FutureOr<void> _onInitState(
    InitCreateCardEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    emit(const LoadingCreateCardState());
    emit(LoadedCreateCardState(CardModel()));
  }

  FutureOr<void> _onChooseImageState(
    ChooseImageEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    File? imagePicked = await uploadImage(event.context);
    if (imagePicked == null) {
      emit(LoadedCreateCardState(CardModel()));
    } else {
      emit(LoadedCreateCardState(CardModel(image: imagePicked.path)));
    }
  }

  FutureOr<void> _onCreateCardEvent(
    CreateCreateCardEvent event,
    Emitter<CreateCardState> emit,
  ) async {
    emit(const LoadingCreateCardState());
    print(event.data.toJson().toString());
    await localDatabase.insertCard(event.data);
    for(var item in event.data.items!){
      await localDatabase.insertItem(item);
    }
    getIt<HomeBloc>().add(const InitHomeEvent());
    emit(const CreateCardSuccessState());
  }
  //
  Future<File?> uploadImage(BuildContext context) async {
    try {
      return await CustomImagePicker.appBottomSheet(context);
    } catch (e) {
      return null;
    }
  }
}
