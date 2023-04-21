part of 'login_bloc.dart';

abstract class LoginEvent extends Equatable {
  const LoginEvent();
}

class LoginEmailChanged extends LoginEvent {
  const LoginEmailChanged({required this.email});
  final String email;

  @override
  List<Object> get props => [email];
}

class LoginPasswordChanged extends LoginEvent {
  const LoginPasswordChanged(this.password);
  final String password;

  @override
  List<Object> get props => [password];
}

class LoginSubmitEvent extends LoginEvent {
  const LoginSubmitEvent(this.loginModel);
  final LoginModel loginModel;

  @override
  List<Object> get props => [loginModel];
}

class ObscurePasswordToggled extends LoginEvent {
  final bool  obscurePassword;
  const ObscurePasswordToggled({this.obscurePassword = false});

  @override
  // TODO: implement props
  List<Object?> get props =>[obscurePassword];
}

class ClearEmailEvent extends LoginEvent {
  final String email;
  const ClearEmailEvent({this.email = ''});
  @override
  // TODO: implement props
  List<Object?> get props => [email];
}
