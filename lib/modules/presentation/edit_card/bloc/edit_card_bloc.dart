import 'dart:async';
import 'dart:math';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/modules/data/datasource/card_local.dart';
import 'package:flutter_template/modules/data/model/card.model.dart';
import 'package:flutter_template/modules/presentation/home/bloc/home_bloc.dart';
import 'package:injectable/injectable.dart';

part 'edit_card_event.dart';
part 'edit_card_state.dart';

@Injectable()
class EditCardBloc extends Bloc<EditCardEvent, EditCardState> {
  final LocalDatabase localDatabase = LocalDatabase();
  EditCardBloc() : super(const InitEditCardState()) {
    on<InitEditCardEvent>(_onInitState);
    on<UpdateEditCardEvent>(_onUpdateState);
  }


  FutureOr<void> _onInitState(
    InitEditCardEvent event,
    Emitter<EditCardState> emit,
  ) async {
    
  }

  FutureOr<void> _onUpdateState(
    UpdateEditCardEvent event,
    Emitter<EditCardState> emit,
  ) async {
    emit(const LoadingEditCardState());
    await localDatabase.deleteCard(event.old.id??0);
    event.old.items!.forEach((element) async {
      await localDatabase.deleteItem(element.id??0);
    });
    await localDatabase.insertCard(event.newData);
    for(var item in event.newData.items!){
      await localDatabase.insertItem(item);
    }
    getIt<HomeBloc>().add(const InitHomeEvent());
    emit(UpdatedEditCardState(cardModel: event.newData));
  }
}
