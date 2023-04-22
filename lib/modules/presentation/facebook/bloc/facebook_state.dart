part of 'facebook_bloc.dart';

@immutable
abstract class FacebookState extends Equatable {
  const FacebookState();
  @override
  List<Object?> get props => [];
}


class InitFacebookState extends FacebookState {
  const InitFacebookState();
  

  @override
  List<Object?> get props => [];
}

class LoadingFacebookState extends FacebookState {
  const LoadingFacebookState();
  

  @override
  List<Object?> get props => [];
}

class CreatedFacebookState extends FacebookState {
  const CreatedFacebookState();
  

  @override
  List<Object?> get props => [];
}

class LoadedFacebookState extends FacebookState {
  const LoadedFacebookState();

  @override
  List<Object?> get props => [];
}

class ErrorFacebookState extends FacebookState {
  const ErrorFacebookState(this.errorMessage,);
  final String errorMessage;
  

  @override
  List<Object?> get props => [errorMessage];
}
