import 'package:bloc/bloc.dart';
import 'package:flutter_template/modules/data/model/refresh_token.model.dart';
import 'package:formz/formz.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';

//
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/modules/presentation/auth/auth_bloc/auth_bloc.dart';
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:flutter_template/modules/domain/usecase/user_usecase.dart';
import 'package:flutter_template/modules/presentation/auth/validate/login.model.export.dart';

part 'login_event.dart';

part 'login_state.dart';

@Singleton()
class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final LoginUserUseCase loginUserUseCase;

  LoginBloc({
    required this.loginUserUseCase,
  }) : super(const LoginState()) {
    on<LoginEmailChanged>(_onEmailChanged);
    on<LoginPasswordChanged>(_onPasswordChanged);
    on<ObscurePasswordToggled>(_onObscurePasswordToggled);
    on<ClearEmailEvent>(_onClearEmail);
    on<LoginSubmitEvent>(_onLoginEvent);
  }

  void _onEmailChanged(
    LoginEmailChanged event,
    Emitter<LoginState> emit,
  ) {
    final emailModel = EmailModel.dirty(event.email);
    emit(
      state.copyWith(
        email: emailModel,
        formStatus: Formz.validate([emailModel, state.password])
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
        loginStatus: LoginStatus.validating,
      ),
    );
  }

  void _onPasswordChanged(
    LoginPasswordChanged event,
    Emitter<LoginState> emit,
  ) {
    final passwordModel = PasswordLoginModel.dirty(event.password);
    emit(
      state.copyWith(
        password: passwordModel,
        formStatus: Formz.validate([state.email, passwordModel])
            ? FormzSubmissionStatus.success
            : FormzSubmissionStatus.failure,
        loginStatus: LoginStatus.validating,
      ),
    );
  }

  void _onObscurePasswordToggled(
    ObscurePasswordToggled event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        obscurePassword: !state.obscurePassword,
        loginStatus: LoginStatus.validating,
      ),
    );
  }

  void _onClearEmail(
    ClearEmailEvent event,
    Emitter<LoginState> emit,
  ) {
    emit(
      state.copyWith(
        email: const EmailModel.dirty(),
        loginStatus: LoginStatus.validating,
      ),
    );
  }

  Future<void> _onLoginEvent(
    LoginSubmitEvent event,
    Emitter<LoginState> emit,
  ) async {
    final emailModel = EmailModel.dirty(event.loginModel.email);
    final passwordModel = PasswordLoginModel.dirty(event.loginModel.password);
    bool formValidated = Formz.validate([emailModel, passwordModel]);
    if (!formValidated) {
      emit(
        state.copyWith(
          email: emailModel,
          password: passwordModel,
          formStatus: formValidated
              ? FormzSubmissionStatus.success
              : FormzSubmissionStatus.failure,
          loginStatus: LoginStatus.validating,
        ),
      );
      return;
    }
    emit(state.copyWith(loginStatus: LoginStatus.inProgress));
    final response = await loginUserUseCase.login(event.loginModel);
    response.fold((failure) {
      emit(
        state.copyWith(
          loginStatus: LoginStatus.failure,
          errorMessage: failure.message,
        ),
      );
    }, (authResponse) {
      getIt<AuthBloc>().add(LoggedEvent(authResponseModel: authResponse));
      emit(state.copyWith(loginStatus: LoginStatus.success));
    });

    // TODO: Testing and auto login, PLEASE REMOVE THIS WHEN BUILDING APP
    getIt<AuthBloc>().add(LoggedEvent(
        authResponseModel: AuthResponseModel(
            token:
                TokenModel(refreshToken: '', accessToken: '', expiresIn: 123),
            user: UserModel(),),),);
  }
}
