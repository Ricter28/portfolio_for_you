part of 'edit_card_bloc.dart';

@immutable
abstract class EditCardEvent extends Equatable {
  const EditCardEvent();

  @override
  List<Object?> get props => [];
}


class InitEditCardEvent extends EditCardEvent {
  const InitEditCardEvent();
  

  @override
  List<Object?> get props => [];
}

class UpdateEditCardEvent extends EditCardEvent {
  const UpdateEditCardEvent(this.old, this.newData,);
  final CardModel old;
  final CardModel newData;
  

  @override
  List<Object?> get props => [old,newData];
}