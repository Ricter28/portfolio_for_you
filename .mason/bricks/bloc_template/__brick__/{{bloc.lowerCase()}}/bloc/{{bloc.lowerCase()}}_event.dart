part of '{{bloc.lowerCase()}}_bloc.dart';

@immutable
abstract class {{bloc.pascalCase()}}Event extends Equatable {
  const {{bloc.pascalCase()}}Event();

  @override
  List<Object?> get props => [];
}

{{#events}}
class {{name.pascalCase()}}{{bloc.pascalCase()}}Event extends {{bloc.pascalCase()}}Event {
  const {{name.pascalCase()}}{{bloc.pascalCase()}}Event({{#variables}} this.{{name}},{{/variables}});
  {{#variables}}final {{{type}}} {{name}};
  {{/variables}}

  @override
  List<Object?> get props => [{{#variables}}{{name}},{{/variables}}];
}
{{/events}}