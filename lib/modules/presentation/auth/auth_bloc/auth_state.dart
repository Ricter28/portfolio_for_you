part of 'auth_bloc.dart';

abstract class AuthState extends Equatable {
  const AuthState();

}

class LoadingSplashState extends AuthState {
  @override
  List<Object?> get props => [];
}

class CheckAuthState extends AuthState {
  @override
  List<Object?> get props => [];
}

class UnauthenticatedState extends AuthState {
  @override
  List<Object?> get props => [];
}

class AuthenticatedState extends AuthState {
  const AuthenticatedState();

  @override
  List<Object?> get props => [];
}

