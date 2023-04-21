import 'package:formz/formz.dart';

enum EmailValidationError { invalid, empty }

class EmailModel extends FormzInput<String, EmailValidationError> {
  const EmailModel.pure() : super.pure('');
  const EmailModel.dirty([super.value = '']) : super.dirty();

  static final _emailRegExp = RegExp(
    r'^[a-zA-Z\d.!#$%&’*+/=?^_`{|}~-]+@[a-zA-Z\d-]+(?:\.[a-zA-Z\d-]+)*$',
  );

  @override
  EmailValidationError? validator(String value) {
    //Email empty
    if (value.isEmpty) return EmailValidationError.empty;

    //Email invalid
    if (!_emailRegExp.hasMatch(value)) return EmailValidationError.invalid;

    return null;
  }
}

extension EmailValidate on EmailValidationError {
  String get getTextValidate {
    switch (this) {
      case EmailValidationError.empty:
        return 'Email không được để trống';
      case EmailValidationError.invalid:
        return 'Email không hợp lệ';
    }
  }
}
