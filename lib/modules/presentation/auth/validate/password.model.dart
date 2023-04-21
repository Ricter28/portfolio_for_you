import 'package:formz/formz.dart';

enum PasswordValidationError { invalid, empty }

class PasswordLoginModel extends FormzInput<String, PasswordValidationError> {
  const PasswordLoginModel.pure() : super.pure('');

  const PasswordLoginModel.dirty([super.value = '']) : super.dirty();

  @override
  PasswordValidationError? validator(String value) {
    //Password empty
    if (value.isEmpty) return PasswordValidationError.empty;
    return null;
  }
}

class PasswordRegisterModel
    extends FormzInput<String, PasswordValidationError> {
  const PasswordRegisterModel.pure() : super.pure('');

  const PasswordRegisterModel.dirty([super.value = '']) : super.dirty();

  static final _passwordRegex =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~]).{8,}$');

  @override
  PasswordValidationError? validator(String value) {
    //Password empty
    if (value.isEmpty) return PasswordValidationError.empty;

    //Password invalid
    if (!_passwordRegex.hasMatch(value)) return PasswordValidationError.invalid;
    return null;
  }
}

extension PasswordValidate on PasswordValidationError {
  String get getTextValidate {
    switch (this) {
      case PasswordValidationError.empty:
        return 'Mật khẩu không được để trống';
      case PasswordValidationError.invalid:
        return 'Mật khẩu phải ít nhất 8 ký tự bao gồm chữ cái và chữ số';
    }
  }
}
