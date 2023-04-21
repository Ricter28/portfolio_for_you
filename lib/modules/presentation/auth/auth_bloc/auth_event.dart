part of 'auth_bloc.dart';

abstract class AuthEvent extends Equatable {
  const AuthEvent();

  @override
  List<Object?> get props => [];
}

class CheckAuthEvent extends AuthEvent {}

class CheckInternetEvent extends AuthEvent {}

class LogoutEvent extends AuthEvent {}

class LoggedEvent extends AuthEvent {
  const LoggedEvent({required this.authResponseModel});
  final AuthResponseModel authResponseModel;
  
  @override
  List<Object?> get props => [authResponseModel];
}
