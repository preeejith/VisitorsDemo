// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitorsbook/bloc/addvisitorbloc/addvisitorevent.dart';
import 'package:visitorsbook/config.dart';
import 'package:visitorsbook/models/visitormodel.dart';
import 'package:visitorsbook/ui/bottomNavigation.dart';

import '../bloc/addvisitorbloc/addvisitorbloc.dart';
import '../bloc/addvisitorbloc/addvisitorstate.dart';

class AddNewVisitor extends StatefulWidget {
  final String qrnumber;
  const AddNewVisitor({required this.qrnumber, super.key});

  @override
  State<AddNewVisitor> createState() => _AddNewVisitorState();
}

class _AddNewVisitorState extends State<AddNewVisitor> {
  final TextEditingController _name = TextEditingController();
  final TextEditingController _number = TextEditingController();
  final TextEditingController _purpose = TextEditingController();
  final TextEditingController _personmeet = TextEditingController();
  final TextEditingController _vehicle = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.appbarColor,
          title: const Center(
            child: Text(
              "Registration",
              style: TextStyle(color: Colors.white),
            ),
          )),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            //mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                'assets/register.jpg',
                height: 300,
                width: 300,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  maxLines: 1,
                  controller: _name,
                  keyboardType: TextInputType.text,
                  decoration: InputDecoration(
                    hintText: 'Enter Visitor Name',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Color(0xff5D3FD3)),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          const BorderSide(width: 3, color: Color(0xff5D3FD3)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person,
                          color: Color(0xff5D3FD3),
                        )),
                    suffixIcon: IconButton(
                      icon: Icon(
                        Icons.person_add,
                        color: Color(0xff5D3FD3),
                      ),
                      onPressed: () {},
                    ),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  validator: (value) {
                    String pattern = r'(^(?:[+0]9)?[0-9]{10}$)';
                    RegExp regExp = RegExp(pattern.toString());
                    if (value!.isEmpty) {
                      return 'Cannot be empty';
                    } else if (value.length > 10) {
                      return 'Please enter your 10 digit mobile number';
                    } else if (!regExp.hasMatch(value)) {
                      return 'Please enter valid mobile number';
                    }
                    return null;
                  },
                  maxLines: 1,
                  controller: _number,
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                    hintText: 'Enter Mobile Number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Color(0xff5D3FD3)),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff5D3FD3)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.phone_android,
                          color: Color(0xff5D3FD3),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  controller: _purpose,
                  decoration: InputDecoration(
                    hintText: 'Enter Visitor purpose',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Color(0xff5D3FD3)),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff5D3FD3)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.edit,
                          color: Color(0xff5D3FD3),
                        )),
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Cannot be empty';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextFormField(
                  validator: (value) {
                    if (value!.isEmpty) {
                      return 'Cannot be empty';
                    }
                    return null;
                  },
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  controller: _personmeet,
                  decoration: InputDecoration(
                    hintText: 'Person(s) to Meet',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Color(0xff5D3FD3)),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff5D3FD3)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.person_pin_outlined,
                          color: Color(0xff5D3FD3),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15, right: 15),
                child: TextField(
                  keyboardType: TextInputType.text,
                  maxLines: 1,
                  controller: _vehicle,
                  decoration: InputDecoration(
                    hintText: 'Enter Vechicle Number',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15.0),
                      borderSide: BorderSide(color: Color(0xff5D3FD3)),
                    ),
                    border: OutlineInputBorder(
                      borderSide:
                          BorderSide(width: 3, color: Color(0xff5D3FD3)),
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    prefixIcon: IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.pedal_bike,
                          color: Color(0xff5D3FD3),
                        )),
                  ),
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(18),
                  child: SizedBox(
                    height: 40,
                    child: MaterialButton(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(5.0))),
                      elevation: 5.0,
                      height: 40,
                      color: AppColors.buttonColor,
                      child: BlocConsumer<AddVisitorBloc, AddVisitorState>(
                          builder: (context, state) {
                        if (state is AddVisitorin) {
                          return const SizedBox(
                            height: 18.0,
                            width: 18.0,
                            child: CircularProgressIndicator(
                              valueColor:
                                  AlwaysStoppedAnimation<Color>(Colors.black),
                              strokeWidth: 2,
                            ),
                          );
                        } else {
                          return const Text('SUBMIT',
                              style: TextStyle(
                                  fontFamily: "Kumba",
                                  fontSize: 16.0,
                                  color: Colors.white));
                        }
                      }, listener: (context, state) {
                        if (state is AddVisitorSuccess) {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const BottomNavigation()));
                        }
                      }),
                      onPressed: () {
                        addvisitor();
                      },
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void addvisitor() async {
    VisitorModel visitorModel = VisitorModel();

    if (_name.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Persons name empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (_number.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "Phone empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (_purpose.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "purpose empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else if (_personmeet.text.isEmpty) {
      Fluttertoast.showToast(
        msg: "person to meet  empty",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      visitorModel.qrnumber = widget.qrnumber.toString();
      visitorModel.visitorname = _name.text.toString();
      visitorModel.phonenumber = _number.text.toString();
      visitorModel.purpose = _purpose.text.toString();
      visitorModel.persontomeet = _personmeet.text.toString();
      visitorModel.vechilenumber = _vehicle.text.toString();

      BlocProvider.of<AddVisitorBloc>(context)
          .add(AddVisitor(visitorModel: visitorModel));
    }
  }
}
