import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorsbook/bloc/addvisitorbloc/addvisitorbloc.dart';
import 'package:visitorsbook/bloc/authbloc/authbloc.dart';
import 'package:visitorsbook/bloc/checkqrbloc/scanqrbloc.dart';
import 'package:visitorsbook/bloc/visitorslistblc.dart';

import 'package:visitorsbook/helper/prefmanager.dart';
import 'package:visitorsbook/ui/authenticate/authenticate.dart';
import 'package:visitorsbook/ui/bottomNavigation.dart';
import 'package:visitorsbook/ui/qrscanner.dart';

Future<void> main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
        providers: [
          BlocProvider<AuthBloc>(create: (BuildContext context) => AuthBloc()),
          BlocProvider<CheckQrBloc>(
              create: (BuildContext context) => CheckQrBloc()),
          BlocProvider<AddVisitorBloc>(
              create: (BuildContext context) => AddVisitorBloc()),
          BlocProvider<VisitorListBloc>(
              create: (BuildContext context) => VisitorListBloc()),
        ],
        child: MaterialApp(
          theme: ThemeData(
              fontFamily: "Kumba", primaryColor: const Color(0xff5D3FD3)),
          home: const MyHomePage(),
          debugShowCheckedModeBanner: false,
        ));
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<MyHomePage> {
  @override
  void initState() {
    super.initState();
    fetcher();
  }

  void fetcher() async {
    bool isLoggedIn = await PrefManager.getIsLoggedIn();
    if (isLoggedIn == true) {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigation())));
    } else {
      Timer(
          const Duration(seconds: 3),
          () => Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Authenticate())));
    }

    // Timer(
    //     const Duration(seconds: 3),
    //     () => Navigator.pushReplacement(context,

    //         MaterialPageRoute(builder: (context) =>  VisitorScanerCode())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: MediaQuery.of(context).size.height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/mainimg.jpg"),
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
