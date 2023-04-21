part of 'create_card_bloc.dart';

@immutable
abstract class CreateCardEvent extends Equatable {
  const CreateCardEvent();

  @override
  List<Object?> get props => [];
}


class InitCreateCardEvent extends CreateCardEvent {
  const InitCreateCardEvent();
  

  @override
  List<Object?> get props => [];
}


class ChooseImageEvent extends CreateCardEvent {
  const ChooseImageEvent(this.context);
  final BuildContext context;

  @override
  List<Object?> get props => [context];
}

class CreateCreateCardEvent extends CreateCardEvent {
  const CreateCreateCardEvent( this.data,);
  final CardModel data;
  

  @override
  List<Object?> get props => [data,];
}