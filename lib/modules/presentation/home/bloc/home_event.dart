part of 'home_bloc.dart';

@immutable
abstract class HomeEvent extends Equatable {
  const HomeEvent();

  @override
  List<Object?> get props => [];
}

class InitHomeEvent extends HomeEvent {
  const InitHomeEvent();
  @override
  List<Object?> get props => [];
}

class AddToSpotlightEvent extends HomeEvent {
  const AddToSpotlightEvent({required this.cardModel});
  final CardModel cardModel;
  @override
  List<Object?> get props => [cardModel];
}

class RemoveFromSpotlightEvent extends HomeEvent {
  const RemoveFromSpotlightEvent({required this.cardModel});
  final CardModel cardModel;
  @override
  List<Object?> get props => [cardModel];
}

class DeleteCardEvent extends HomeEvent {
  const DeleteCardEvent({required this.cardModel});
  final CardModel cardModel;
  @override
  List<Object?> get props => [cardModel];
}

class SearchEvent extends HomeEvent {
  const SearchEvent({required this.keywork});
  final String keywork;
  @override
  List<Object?> get props => [keywork];
}
