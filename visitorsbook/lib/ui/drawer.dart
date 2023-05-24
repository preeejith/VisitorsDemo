// ignore_for_file: prefer_interpolation_to_compose_strings

import 'package:flutter/material.dart';
import 'package:visitorsbook/bloc/authbloc/authstate.dart';
import 'package:visitorsbook/data/webclient.dart';
import 'package:visitorsbook/helper/prefmanager.dart';
import 'package:visitorsbook/ui/authenticate/authenticate.dart';

class NavDrawer extends StatefulWidget {
  const NavDrawer({Key? key}) : super(key: key);

  @override
  _NavDrawerState createState() => _NavDrawerState();
}

class _NavDrawerState extends State<NavDrawer> {
  bool isAdmin = true;
  @override
  void initState() {
    super.initState();
  }

  final drawerTextStyle = const TextStyle(
      fontWeight: FontWeight.w600, color: Colors.white, fontSize: 15);
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          Flexible(
            child: Container(
              //color: Colors.white,
              child: ListView(
                children: <Widget>[
                  Container(
                    padding: const EdgeInsets.symmetric(
                        vertical: 15, horizontal: 15),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            // const Image(
                            //   height: 40,
                            //   width: 40,
                            //   image: AssetImage('assets/applogo.png'),
                            // ),
                            const SizedBox(
                              width: 16,
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              // ignore: prefer_const_literals_to_create_immutables
                              children: [
                                // ignore: prefer_const_constructors
                                Text(
                                  "Visitors Diary",
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                      fontSize: 20),
                                ),
                                const SizedBox(
                                  height: 5,
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  const SizedBox(height: 50),
                  // InkWell(
                  //   // onTap: () async {
                  //   //   const url =
                  //   //       'https://play.google.com/store/apps/details?id=leopard.tech.lab.big4mapper';
                  //   //   // ignore: deprecated_member_use
                  //   //   if (await canLaunch(url)) {
                  //   //     // ignore: deprecated_member_use
                  //   //     await launch(url);
                  //   //   } else {
                  //   //     throw 'Could not launch $url';
                  //   //   }
                  //   //   Navigator.pop(context);
                  //   // },
                  //   child: Row(
                  //     crossAxisAlignment: CrossAxisAlignment.center,
                  //     children: <Widget>[
                  //       const Padding(
                  //         padding: EdgeInsets.only(
                  //             left: 15, right: 15, top: 10, bottom: 10),
                  //         child: Image(
                  //           height: 30,
                  //           width: 30,
                  //           image: AssetImage('assets/rateapp.png'),
                  //         ),
                  //       ),
                  //       const SizedBox(
                  //         width: 8,
                  //       ),
                  //       Text(
                  //         'Rate App',
                  //         style: drawerTextStyle,
                  //       )
                  //     ],
                  //   ),
                  // ),

                  InkWell(
                    onTap: () async {
                      var token = await PrefManager.getToken();
                      await WebClient.get(
                          '/logout?deviceToken=' + token.toString());
                      PrefManager.clearToken();
                      // ignore: use_build_context_synchronously
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const Authenticate()));
                    },
                    child: Row(
                      // ignore: prefer_const_literals_to_create_immutables
                      children: [
                        const Padding(
                          padding: EdgeInsets.only(
                              left: 15, right: 15, top: 10, bottom: 10),
                          // child: Image(
                          //   height: 30,
                          //   width: 30,
                          //   image: AssetImage('assets/logout.png'),
                          // ),
                        ),
                        const SizedBox(
                          width: 8,
                        ),
                        const Text(
                          "Logout",
                          style: TextStyle(color: Colors.black),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            // ignore: prefer_const_literals_to_create_immutables
            children: [
              const SizedBox(
                height: 15,
              ),
              Padding(
                padding: const EdgeInsets.only(left: .0, bottom: 5),
                child: Container(
                  height: 50,
                  width: 302,
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/leopard_logo.png"),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
