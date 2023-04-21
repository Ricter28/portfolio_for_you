part of 'create_card_bloc.dart';

@immutable
abstract class CreateCardState extends Equatable {
  const CreateCardState();
  @override
  List<Object?> get props => [];
}


class InitCreateCardState extends CreateCardState {
  const InitCreateCardState();
  

  @override
  List<Object?> get props => [];
}

class LoadingCreateCardState extends CreateCardState {
  const LoadingCreateCardState();
  

  @override
  List<Object?> get props => [];
}

class CreateCardSuccessState extends CreateCardState {
  const CreateCardSuccessState();
  

  @override
  List<Object?> get props => [];
}

class CreatedCreateCardState extends CreateCardState {
  const CreatedCreateCardState();
  

  @override
  List<Object?> get props => [];
}

class LoadedCreateCardState extends CreateCardState {
  const LoadedCreateCardState(this.cardModel,);
  final CardModel cardModel;
  

  @override
  List<Object?> get props => [cardModel];
}

class ErrorCreateCardState extends CreateCardState {
  const ErrorCreateCardState(this.errorMessage,);
  final String errorMessage;
  

  @override
  List<Object?> get props => [errorMessage];
}
