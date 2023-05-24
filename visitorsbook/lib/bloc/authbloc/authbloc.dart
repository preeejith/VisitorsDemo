import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitorsbook/bloc/authbloc/authevent.dart';
import 'package:visitorsbook/bloc/authbloc/authstate.dart';
import 'package:visitorsbook/helper/prefmanager.dart';
import 'package:visitorsbook/models/usermodel.dart';
import 'package:visitorsbook/repositories/repositries.dart';

class AuthBloc extends Bloc<AuthEvent, AuthState> {
  AuthBloc() : super(Authinitial()) {
    on<Login>(_login);
  }

  Future _login(Login event, Emitter<AuthState> emit) async {
    emit(Loggingin());
    UserModel userModel;

    userModel = await Repository()
        .login(url: '/login', data: event.loginModel.toJson());
    if (userModel.status == true) {
      await PrefManager.setIsLoggedIn(true);
      await PrefManager.setToken(userModel.token.toString());
      await PrefManager.setUserId(userModel.data!.sId.toString());

      emit(LoginSuccess(userModel: userModel));
    } else if (userModel.status == false) {
      Fluttertoast.showToast(
        msg: userModel.msg.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      emit(PhonecheckError(error: userModel.msg.toString()));
    }
  }

  // @override
  // Stream<AuthState> mapEventToState(AuthEvent event) async* {
  //   if (event is CheckPhone) {
  //     yield Loggingin();
  //     UserModel userModel;

  //     Map map = {
  //       "phone": event.number,
  //     };
  //     userModel = await Repository().login(url: '/user/login', data: map);
  //     if (userModel.status == true) {
  //       yield Phonechecksuccess();
  //     } else if (userModel.status == false) {
  //       yield PhonecheckError(error: userModel.msg.toString());
  //     }
  //   }
  //   if (event is GenerateOtp) {
  //     yield Loggingin();
  //     Map map = {"phone": event.phoneNumber};
  //     GenerateOtpModel generateOtpModel =
  //         await Repository().generateOtp(url: '/user/sendotp', data: map);
  //     if (generateOtpModel.status == true) {
  //       yield OTPSendSuccess(generateOtpModel: generateOtpModel);
  //     } else {
  //       yield OTPSendFailed(error: generateOtpModel.msg.toString());
  //     }
  //   }
  //   if (event is LoginWithOtp) {
  //     yield Loggingin();
  //     Map map = {"phone": event.phoneNumber, "otp": event.otp};
  //     LoginModel loginModel = await Repository()
  //         .loginWithOtp(url: '/user/otpverification', data: map);
  //     if (loginModel.status == true && loginModel.otpver == true) {
  //       await PrefManager.setIsLoggedIn(true);
  //       await PrefManager.setToken(loginModel.token);
  //       yield LoginSuccess(loginModel: loginModel);
  //     } else {
  //       yield LoginFailed(error: loginModel.msg.toString());
  //     }
  //   }
  // }
}
