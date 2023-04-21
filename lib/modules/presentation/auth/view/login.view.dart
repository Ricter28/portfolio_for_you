import 'package:auto_route/auto_route.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_template/common/theme/app_color.dart';
import 'package:flutter_template/common/utils/toast.util.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//
import 'package:flutter_template/modules/data/model/user.model.dart';
import 'package:flutter_template/common/theme/app_size.dart';
import 'package:flutter_template/di/di.dart';
import 'package:flutter_template/common/theme/text_styles.dart';
import 'package:flutter_template/common/widgets/app_rounded_button.widget.dart';
import 'package:flutter_template/common/widgets/app_text_form_field.widget.dart';
import 'package:flutter_template/generated/locale_keys.g.dart';
import 'package:flutter_template/modules/presentation/auth/login_bloc/login_bloc.dart';
import 'package:flutter_template/modules/presentation/auth/validate/login.model.export.dart';

@RoutePage()
class LoginView extends StatelessWidget {
  LoginView({super.key});

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();

  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: BlocProvider.value(
            value: getIt<LoginBloc>(),
            child: SingleChildScrollView(
              child: Container(
                margin: const EdgeInsets.symmetric(
                  horizontal: AppSize.kHorizontalSpace,
                ),
                child: _buildForm(),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildForm() {
    return Form(
      key: _key,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.login_welcome_back.tr(),
            style: AppStyles.body2,
          ),
          const SizedBox(height: 40),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) => previous.email != current.email,
            builder: (context, state) {
              return TextFieldWidget(
                label: LocaleKeys.texts_email_address.tr(),
                keyboardType: TextInputType.emailAddress,
                hintText: 'name@email.com',
                onChanged: (email) => context
                    .read<LoginBloc>()
                    .add(LoginEmailChanged(email: email)),
                controller: _emailController,
                textInputAction: TextInputAction.next,
                errorText: state.email.displayError?.getTextValidate,
                suffixIcon: _emailController.text.isNotEmpty
                    ? const Icon(Icons.clear)
                    : null,
                onTapSuffixIcon: () {
                  _emailController.clear();
                  getIt<LoginBloc>().add(const ClearEmailEvent());
                },
              );
            },
          ),
          const SizedBox(height: 15),
          BlocBuilder<LoginBloc, LoginState>(
            buildWhen: (previous, current) =>
                previous.password != current.password ||
                previous.obscurePassword != current.obscurePassword,
            builder: (context, state) {
              return TextFieldWidget(
                label: LocaleKeys.texts_password.tr(),
                keyboardType: TextInputType.text,
                obscureText: state.obscurePassword ? false : true,
                hintText: 'Nhập vào mật khẩu',
                controller: _passwordController,
                errorText: state.password.displayError?.getTextValidate,
                onChanged: (password) => context
                    .read<LoginBloc>()
                    .add(LoginPasswordChanged(password)),
                suffixIcon: Icon(
                  state.obscurePassword
                      ? Icons.visibility_outlined
                      : Icons.visibility_off_outlined,
                ),
                onTapSuffixIcon: () =>
                    getIt<LoginBloc>().add(const ObscurePasswordToggled()),
              );
            },
          ),
          const SizedBox(height: 15),
          BlocConsumer<LoginBloc, LoginState>(
            listenWhen: (context, state) {
              return state.loginStatus == LoginStatus.failure;
            },
            listener: (context, state) {
              if (state.errorMessage.isNotEmpty &&
                  state.loginStatus == LoginStatus.failure) {
                // DialogUtil.showCustomDialog(context, title: state.errorMessage);
                ToastUtil.showError(context, text: state.errorMessage);
              }
            },
            builder: (context, state) {
              return AppRoundedButton(
                onPressed: () async{
                  final loginModel = LoginModel(
                    email: _emailController.text,
                    password: _passwordController.text,
                  );
                  context.read<LoginBloc>().add(LoginSubmitEvent(loginModel));
                },
                isLoading: state.loginStatus == LoginStatus.inProgress,
                disableBackgroundColor: AppColors.kBlack3,
                child: Text(
                  LocaleKeys.login_sign_in.tr(),
                  style: AppStyles.body2.copyWith(
                    color: AppColors.kWhite,
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
