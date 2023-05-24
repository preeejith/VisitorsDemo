// ignore_for_file: prefer_const_literals_to_create_immutables, prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:visitorsbook/bloc/visitorslistblc.dart';

import 'package:visitorsbook/config.dart';

class History extends StatefulWidget {
  const History({super.key});

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  int page = 1, totalpages = 1;
  var d1 = DateFormat('dd-MMM-yyyy');

  bool stopListening = true;
  String convert(String uTCTime) {
    var dateFormat = DateFormat("dd-MM-yyyy hh:mm");
    var utcDate = dateFormat.format(DateTime.parse(uTCTime));
    var localDate = dateFormat.parse(utcDate, true).toLocal().toString();

    return localDate;
  }

  @override
  void initState() {
    BlocProvider.of<VisitorListBloc>(context)
        .add(GetVisitorList(page: 1, limit: 10, filter: "checkout"));
    // identificationList();
    super.initState();
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
      body: BlocConsumer<VisitorListBloc, VisitorListState>(
        buildWhen: (previous, current) {
          return current is DeliveredVisitorListSuccess;
        },
        builder: (context, state) {
          if (state is DeliveredVisitorListSuccess) {
            return state.visitorListModel.data!.isEmpty
                ? const Center(
                    child: Text("No data found"),
                  )
                : BlocListener<VisitorListBloc, VisitorListState>(
                    listener: ((context, addData) {
                      if (addData is AddVisitorList) {
                        state.visitorListModel.data!
                            .addAll(addData.visitorListModel.data!);
                        page = page + 1;
                        setState(() {});
                      }
                    }),
                    child: _visitorsList(context, state));
          } else if (state is DeliveredVisitorListError) {
            return const Center(
                child: Text("No Data Found",
                    style: TextStyle(color: Colors.black)));
          } else {
            return Container();
          }
        },
        listener: (context, state) {
          if (state is DeliveredVisitorListSuccess) {
            if (state.visitorListModel.totallength!.remainder(10) == 0) {
              totalpages = (state.visitorListModel.totallength! ~/ 10);
              setState(() {});
            } else {
              totalpages = ((state.visitorListModel.totallength! ~/ 10) + 1);
              setState(() {});
            }
          }
        },
      ),
    );
  }

  Widget _visitorsList(BuildContext context, state) {
    stopListening = false;
    return NotificationListener<ScrollNotification>(
        onNotification: (ScrollNotification scrollInfo) {
          if (scrollInfo.metrics.pixels == scrollInfo.metrics.maxScrollExtent &&
              page < totalpages &&
              stopListening == false) {
            context.read<VisitorListBloc>().add(
                GetVisitorList(page: page + 1, limit: 10, filter: "checkout"));
            stopListening = true;
            setState(() {});
          }
          return true;
        },
        child: Padding(
          padding:
              const EdgeInsets.only(top: 10, bottom: 10, left: 5, right: 5),
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: state.visitorListModel.data.length + 1,
              itemBuilder: (context, i) {
                if (i == 0) {
                  return Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      children: [
                        const Text(
                          "Visitors List",
                          style:
                              TextStyle(color: Color(0xff5D3FD3), fontSize: 20),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                      ],
                    ),
                  );
                }
                i -= 1;
                return Column(
                  children: <Widget>[
                    Card(
                      elevation: 4,
                      child: Column(
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(
                                left: 10, right: 10, top: 5, bottom: 5),
                            child: Row(
                              children: <Widget>[
                                // ignore: prefer_const_constructors
                                Expanded(
                                  flex: 0,
                                  child: const CircleAvatar(
                                      radius: 40,
                                      backgroundImage:
                                          AssetImage('assets/profile.png')),
                                ),
                                const SizedBox(
                                  width: 20,
                                ),
                                Expanded(
                                  flex: 1,
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      // ignore: prefer_const_constructors
                                      Text(
                                        state.visitorListModel.data[i]
                                                .visitorname ??
                                            "",
                                        style: const TextStyle(
                                            color: Color(0xff5D3FD3),
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      // ignore: prefer_const_constructors
                                      Text("VM 120"),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      state.visitorListModel.data[i]
                                                  .persontomeet !=
                                              null
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  "To Meet : ",
                                                ),
                                                Text(state.visitorListModel
                                                    .data[i].persontomeet),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      state.visitorListModel.data[i].purpose !=
                                              null
                                          ? Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              children: <Widget>[
                                                const Text(
                                                  "Purpose : ",
                                                ),
                                                Text(state.visitorListModel
                                                    .data[i].purpose),
                                              ],
                                            )
                                          : const SizedBox.shrink(),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const Divider(
                            thickness: 1,
                            color: Colors.black,
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 12, right: 12),
                            child: IntrinsicHeight(
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  state.visitorListModel.data[i]
                                              .checkinDateTime !=
                                          null
                                      ? Text(
                                          "Checked In :${convert(state.visitorListModel.data[i].checkinDateTime.toString()).split(":00").first}",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontFamily: "AMM",
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff393939)))
                                      : SizedBox.shrink(),
                                  VerticalDivider(
                                    thickness: 2,
                                    color: Colors.black,
                                  ),
                                  state.visitorListModel.data[i]
                                              .checkouDateTime !=
                                          null
                                      ? Text(
                                          "Checked Out :${convert(state.visitorListModel.data[i].checkouDateTime.toString()).split(":00").first}",
                                          style: const TextStyle(
                                              fontSize: 10,
                                              fontFamily: "AMM",
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xff393939)))
                                      : SizedBox.shrink()
                                ],
                              ),
                            ),
                          ),
                          Container(
                            height: 10,
                          ),
                          // state.visitorListModel.data[i]
                          //             .checkinDateTime !=
                          //         null
                          //     ? Row(
                          //         mainAxisAlignment:
                          //             MainAxisAlignment.start,
                          //         children: <Widget>[
                          //           const Text(
                          //             "Checked In : ",
                          //           ),
                          //           Text(
                          //               convert(state
                          //                       .visitorListModel
                          //                       .data[i]
                          //                       .checkinDateTime
                          //                       .toString())
                          //                   .split(":00")
                          //                   .first,
                          //               style: const TextStyle(
                          //                   fontSize: 12,
                          //                   fontFamily: "AMM",
                          //                   fontWeight:
                          //                       FontWeight.bold,
                          //                   color:
                          //                       Color(0xff393939))),
                          //         ],
                          //       )
                          //     : const SizedBox.shrink()
                        ],
                      ),
                    ),
                  ],
                );
              }),
        ));
  }
}
