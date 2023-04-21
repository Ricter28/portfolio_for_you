part of 'edit_card_bloc.dart';

@immutable
abstract class EditCardState extends Equatable {
  const EditCardState();
  @override
  List<Object?> get props => [];
}


class InitEditCardState extends EditCardState {
  const InitEditCardState();
  

  @override
  List<Object?> get props => [];
}

class LoadingEditCardState extends EditCardState {
  const LoadingEditCardState();
  

  @override
  List<Object?> get props => [];
}

class UpdatedEditCardState extends EditCardState {
  const UpdatedEditCardState({required this.cardModel});
  final CardModel cardModel;

  @override
  List<Object?> get props => [cardModel];
}
