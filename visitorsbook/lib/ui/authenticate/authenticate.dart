// ignore_for_file: prefer_typing_uninitialized_variables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:pinput/pinput.dart';
import 'package:visitorsbook/bloc/authbloc/authbloc.dart';
import 'package:visitorsbook/bloc/authbloc/authevent.dart';
import 'package:visitorsbook/bloc/authbloc/authstate.dart';

import 'package:visitorsbook/config.dart';
import 'package:visitorsbook/models/loginmodel.dart';
import 'package:visitorsbook/ui/bottomNavigation.dart';

class Authenticate extends StatefulWidget {
  const Authenticate({super.key});

  @override
  State<Authenticate> createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  TextEditingController username = TextEditingController();
  TextEditingController otp = TextEditingController();
  var defaultPinTheme, focusedPinTheme, submittedPinTheme;
  @override
  void initState() {
    super.initState();
    defaultPinTheme = PinTheme(
      width: 56,
      height: 56,
      textStyle: const TextStyle(
          fontSize: 20,
          color: Color.fromRGBO(30, 60, 87, 1),
          fontWeight: FontWeight.w600),
      decoration: BoxDecoration(
        border: Border.all(color: const Color(0xff5D3FD3)),
        borderRadius: BorderRadius.circular(20),
        color: Colors.grey[100],
      ),
    );

    focusedPinTheme = defaultPinTheme.copyDecorationWith(
      border: Border.all(color: const Color(0xff5D3FD3), width: 2),
      borderRadius: BorderRadius.circular(20),
      color: Colors.grey[100],
    );

    submittedPinTheme = defaultPinTheme.copyWith(
      decoration: defaultPinTheme.decoration!.copyWith(
        color: Colors.grey[100],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.appbarColor,
          title: const Center(
            child: Text(
              "Visitors Book",
              style: TextStyle(color: Colors.white),
            ),
          )),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          //mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(
              'assets/verify.jpg',
              height: 300,
              width: 300,
            ),
            const Text(
              "App Activation",
              style: TextStyle(
                  fontFamily: "Kumba",
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Color(0xff5D3FD3)),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Please Enter Access Number",
                    style: TextStyle(
                        fontFamily: "Kumba", fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: SizedBox(
                  height: 60,
                  child: TextFormField(
                    style: const TextStyle(
                      fontFamily: 'Kumba',
                    ),
                    controller: username,
                    decoration: const InputDecoration(
                        hintText: 'AccessNumber',
                        hintStyle: TextStyle(
                          color: Colors.black38,
                          fontFamily: 'Kumba',
                        ),
                        filled: true,
                        border: InputBorder.none),
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                // ignore: prefer_const_literals_to_create_immutables
                children: [
                  const Text(
                    "Please Enter OTP",
                    style: TextStyle(
                        fontFamily: "Kumba", fontSize: 14, color: Colors.black),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Pinput(
                defaultPinTheme: defaultPinTheme,
                focusedPinTheme: focusedPinTheme,
                submittedPinTheme: submittedPinTheme,
                pinputAutovalidateMode: PinputAutovalidateMode.onSubmit,
                showCursor: true,
                onCompleted: (pin) {
                  otp.text = pin;
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(18),
                child: SizedBox(
                  height: 40,
                  child: MaterialButton(
                      height: 40,
                      minWidth: 130,
                      color: AppColors.buttonColor,
                      child: BlocConsumer<AuthBloc, AuthState>(
                          builder: (context, state) {
                        if (state is Loggingin) {
                          return const SizedBox(
                            height: 18.0,
                            width: 18.0,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(
                                  Color(0xff5D3FD3)),
                              strokeWidth: 2,
                            ),
                          );
                        } else {
                          return const Text(
                            "Activate",
                            style: TextStyle(
                                color: Colors.white, fontFamily: "Kumba"),
                          );
                        }
                      }, listener: (context, state) async {
                        if (state is LoginSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavigation()));
                        }
                        // if (state is LoginSuccess) {
                        //   Navigator.push(
                        //       context,
                        //       MaterialPageRoute(
                        //           builder: (context) =>
                        //               const SelectLanguage()));
                        // }
                      }),
                      onPressed: () {
                        reguestLogin();
                      }),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  void reguestLogin() {
    LoginModel loginModel = LoginModel();

    if (username.text.isEmpty || otp.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Invalid Credentials",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      loginModel.accessnumber = username.text.toString();
      loginModel.key = otp.text.toString();
      BlocProvider.of<AuthBloc>(context).add(Login(loginModel: loginModel));
    }
  }
}
