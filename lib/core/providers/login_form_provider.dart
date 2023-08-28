import 'package:app_name/core/providers/app_form_state.dart';
import 'package:app_name/helpers/extension/validator_extension.dart';
import 'package:app_name/validations/field.dart';
import 'package:app_name/validations/schemas/login_schema.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final loginFormProviderNotifier =
    StateNotifierProvider<LoginFormProvider, AppFormState<LoginSchema>>((ref) {
  return LoginFormProvider();
});

class LoginFormProvider extends StateNotifier<AppFormState<LoginSchema>> {
  LoginFormProvider() : super(AppFormState(LoginSchema.empty()));

  void setEmail(String email) {
    final form = state.form.copyWith(email: Field(value: email));
    late Field<String> emailField;
    final isEmailValid = email.validateEmail();
    if (email.isEmpty) {
      emailField =
          form.email.copyWith(value: email, errorMessage: null, isValid: false);
    } else if (isEmailValid) {
      emailField =
          form.email.copyWith(value: email, errorMessage: null, isValid: true);
    } else {
      emailField = form.email.copyWith(
          value: email, errorMessage: "Enter valid email", isValid: false);
    }

    state = state.copyWith(form: form.copyWith(email: emailField));
  }

  void setPassword(String password) {
    final form = state.form.copyWith(password: Field(value: password));
    late Field<String> passwordField;
    final isEmailValid = password.validatePassword();
    if (password.isEmpty) {
      passwordField = form.password
          .copyWith(value: password, errorMessage: null, isValid: false);
    } else if (isEmailValid) {
      passwordField = form.password
          .copyWith(value: password, errorMessage: null, isValid: true);
    } else {
      passwordField = form.password.copyWith(
          value: password,
          errorMessage: "Enter valid password",
          isValid: false);
    }

    state = state.copyWith(form: form.copyWith(password: passwordField));
  }
}
