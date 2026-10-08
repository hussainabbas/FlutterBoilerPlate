// ignore_for_file: non_constant_identifier_names

import 'package:manawanui/data/models/user_details_response.dart';

class LoginResponse {
  bool? status;
  String? message;
  String? passwordResetToken;
  bool? passwordExpired;
  bool? twoFactorAuth;
  String? phoneDisplayString;
  String? emailDisplayString;
  UserDetailsResponse? response;

  LoginResponse(
      {this.status,
      this.message,
      this.passwordResetToken,
      this.passwordExpired,
      this.twoFactorAuth,
      this.phoneDisplayString,
      this.emailDisplayString,
      this.response});

  LoginResponse.fromJson(Map<String, dynamic> json) {
    status = json['Status'];
    message = json['Message'];
    passwordResetToken = json['PasswordResetToken'];
    passwordExpired = json['PasswordExpired'];
    twoFactorAuth = json['TwoFactorAuth'];
    phoneDisplayString = json['PhoneDisplayString'];
    emailDisplayString = json['EmailDisplayString'];
    response = json['Response'] != null
        ? UserDetailsResponse.fromJson(json['Response'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['Status'] = status;
    data['Message'] = message;
    data['PasswordResetToken'] = passwordResetToken;
    data['PasswordExpired'] = passwordExpired;
    data['TwoFactorAuth'] = twoFactorAuth;
    data['PhoneDisplayString'] = phoneDisplayString;
    data['EmailDisplayString'] = emailDisplayString;
    if (response != null) {
      data['Response'] = response!.toJson();
    }
    return data;
  }
}
