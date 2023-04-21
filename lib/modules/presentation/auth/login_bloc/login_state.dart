part of 'login_bloc.dart';

enum LoginStatus {
  initial,
  success,
  failure,
  inProgress,
  validating,
}

class LoginState extends Equatable {
  const LoginState({
    this.loginStatus = LoginStatus.initial,
    this.email = const EmailModel.pure(),
    this.password = const PasswordLoginModel.pure(),
    this.obscurePassword = false,
    this.errorMessage = '',
    this.formStatus = FormzSubmissionStatus.initial,
  });

  final FormzSubmissionStatus formStatus;
  final LoginStatus loginStatus;
  final EmailModel email;
  final PasswordLoginModel password;
  final bool obscurePassword;
  final String errorMessage;

  LoginState copyWith({
    LoginStatus? loginStatus,
    EmailModel? email,
    PasswordLoginModel? password,
    bool? obscurePassword,
    String? errorMessage,
    FormzSubmissionStatus? formStatus,
  }) {
    return LoginState(
      loginStatus: loginStatus ?? this.loginStatus,
      email: email ?? this.email,
      formStatus: formStatus ?? this.formStatus,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      errorMessage: errorMessage ?? this.errorMessage,
    );
  }

  @override
  List<Object> get props => [
        loginStatus,
        email,
        password,
        obscurePassword,
        errorMessage,
        formStatus,
      ];
}
