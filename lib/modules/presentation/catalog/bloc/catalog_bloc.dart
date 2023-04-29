import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part 'catalog_event.dart';
part 'catalog_state.dart';

class CatalogBloc extends Bloc<CatalogEvent, CatalogState> {
  CatalogBloc() : super(const InitCatalogState()) {
    
    on<InitCatalogEvent>(_onInitState);
   
    on<SearchCatalogEvent>(_onSearchState);
   
    on<CreateCatalogEvent>(_onCreateState);
   
    on<UpdateCatalogEvent>(_onUpdateState);
   
    on<DeleteCatalogEvent>(_onDeleteState);
   
  }


  FutureOr<void> _onInitState(
    InitCatalogEvent event,
    Emitter<CatalogState> emit,
  ) async {
    //TODO: Handle the logic and emit state at here!
  }

  FutureOr<void> _onSearchState(
    SearchCatalogEvent event,
    Emitter<CatalogState> emit,
  ) async {
    //TODO: Handle the logic and emit state at here!
  }

  FutureOr<void> _onCreateState(
    CreateCatalogEvent event,
    Emitter<CatalogState> emit,
  ) async {
    //TODO: Handle the logic and emit state at here!
  }

  FutureOr<void> _onUpdateState(
    UpdateCatalogEvent event,
    Emitter<CatalogState> emit,
  ) async {
    //TODO: Handle the logic and emit state at here!
  }

  FutureOr<void> _onDeleteState(
    DeleteCatalogEvent event,
    Emitter<CatalogState> emit,
  ) async {
    //TODO: Handle the logic and emit state at here!
  }

}
