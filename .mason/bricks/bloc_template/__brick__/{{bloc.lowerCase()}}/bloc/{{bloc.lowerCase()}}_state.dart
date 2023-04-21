part of '{{bloc.lowerCase()}}_bloc.dart';

@immutable
abstract class {{bloc.pascalCase()}}State extends Equatable {
  const {{bloc.pascalCase()}}State();
  @override
  List<Object?> get props => [];
}

{{#states}}
class {{name.pascalCase()}}{{bloc.pascalCase()}}State extends {{bloc.pascalCase()}}State {
  const {{name.pascalCase()}}{{bloc.pascalCase()}}State({{#variables}}this.{{name}},{{/variables}});
  {{#variables}}final {{{type}}} {{name}};
  {{/variables}}

  @override
  List<Object?> get props => [{{#variables}}{{name}}{{/variables}}];
}
{{/states}}