import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/foundation.dart';

part '{{bloc.lowerCase()}}_event.dart';
part '{{bloc.lowerCase()}}_state.dart';

class {{bloc.pascalCase()}}Bloc extends Bloc<{{bloc.pascalCase()}}Event, {{bloc.pascalCase()}}State> {
  {{bloc.pascalCase()}}Bloc() : super(const Init{{bloc.pascalCase()}}State()) {
    {{#events}}
    on<{{name.pascalCase()}}{{bloc.pascalCase()}}Event>(_on{{name.pascalCase()}}State);
   {{/events}}
  }

{{#events}}
  FutureOr<void> _on{{name.pascalCase()}}State(
    {{name.pascalCase()}}{{bloc.pascalCase()}}Event event,
    Emitter<{{bloc.pascalCase()}}State> emit,
  ) async {
    //TODO: Handle the logic and emit state at here!
  }
{{/events}}
}
