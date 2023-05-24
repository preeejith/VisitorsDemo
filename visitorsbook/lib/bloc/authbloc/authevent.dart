

import 'package:equatable/equatable.dart';
import 'package:visitorsbook/models/loginmodel.dart';

abstract class AuthEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class Login extends AuthEvent {
  final LoginModel loginModel;

  Login({
    required this.loginModel,
  });
  @override
  List<Object> get props => [];
}

class GenerateOtp extends AuthEvent {
  final String phoneNumber;

  GenerateOtp({required this.phoneNumber});
  @override
  List<Object> get props => [];
}

class LoginWithOtp extends AuthEvent {
  final String phoneNumber, otp;

  LoginWithOtp({required this.phoneNumber, required this.otp});
  @override
  List<Object> get props => [];
}
