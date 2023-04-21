part of 'home_bloc.dart';

@immutable
abstract class HomeState extends Equatable {
  const HomeState();
  @override
  List<Object?> get props => [];
}

class InitHomeState extends HomeState{}

class LoadingHomeState extends HomeState {
  const LoadingHomeState();

  @override
  List<Object?> get props => [];
}


class LoadedHomeState extends HomeState {
  const LoadedHomeState(this.user, this.cards);
  final UserModel user;
  final List<CardModel> cards;

  @override
  List<Object?> get props => [user, cards];
}
