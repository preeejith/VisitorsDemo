import 'dart:convert';
import 'dart:developer';

import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:visitorsbook/bloc/checkqrbloc/scanqrbloc.dart';
import 'package:visitorsbook/bloc/checkqrbloc/scanqrevent.dart';
import 'package:visitorsbook/bloc/checkqrbloc/scanqrstate.dart';

import 'package:visitorsbook/data/webclient.dart';
import 'package:visitorsbook/homepage.dart';
import 'package:visitorsbook/models/checkqrmodel.dart';
import 'package:visitorsbook/ui/addnewvisitor.dart';
import 'package:visitorsbook/ui/bottomNavigation.dart';

class VisitorScanerCode extends StatefulWidget {
  const VisitorScanerCode({super.key});

  @override
  State<VisitorScanerCode> createState() => _VisitorScanerCodeState();
}

class _VisitorScanerCodeState extends State<VisitorScanerCode> {
  final GlobalKey qrKey = GlobalKey(debugLabel: 'QR');
  Barcode? result;
  QRViewController? controller;

  @override
  Widget build(BuildContext context) {
    var scanArea = (MediaQuery.of(context).size.width < 200 ||
            MediaQuery.of(context).size.height < 200)
        ? 200.0
        : 350.0;
    return Scaffold(
      body: BlocConsumer<CheckQrBloc, CheckQrState>(builder: (context, state) {
        if (state is CheckQrin) {
          return const SizedBox(
            height: 18.0,
            width: 18.0,
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(Colors.black),
              strokeWidth: 2,
            ),
          );
        } else {
          return QRView(
            overlay: QrScannerOverlayShape(
                borderColor: Colors.red,
                borderRadius: 10,
                borderLength: 30,
                borderWidth: 10,
                cutOutSize: scanArea),
            key: qrKey,
            onQRViewCreated: _onQRViewCreated,
          );
        }
      }, listener: (context, state) {
        if (state is CheckQrSuccess) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      AddNewVisitor(qrnumber: result!.code.toString())));
        } else if (state is CheckQrSuccessCheckout) {
          checkout();

          // Navigator.push(
          //     context,
          //     MaterialPageRoute(
          //         builder: (context) => AddNewVisitor(
          //             qrnumber:
          //                 result!.code.toString()
          //                 )));
        } else if (state is CheckQrFailed) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const BottomNavigation()));
        }
      }),
    );
  }

  Future<void> checkout() async {
    var url = '${WebClient.baseUrl}/checkout';

    Map<String, String> requestHeaders = {
      'Content-type': 'application/json',
      'Accept': 'application/json',
    };
    Map data = {'qrnumber': result!.code.toString()};
    var body = json.encode(data);
    var response =
        await http.post(Uri.parse(url), headers: requestHeaders, body: body);

    print(response.body);
    if (json.decode(response.body)['status']) {
      // ignore: use_build_context_synchronously
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const BottomNavigation()));
    } else {}
  }

  void addqr() async {
    CheckQrModel checkqrModel = CheckQrModel();

    if (result == null) {
      Fluttertoast.showToast(
        msg: "Qr not recieved",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } else {
      checkqrModel.qrnumber = result!.code.toString();

      BlocProvider.of<CheckQrBloc>(context)
          .add(CheckQr(checkqrModel: checkqrModel));
    }
  }

  void _onQRViewCreated(QRViewController controller) {
    this.controller = controller;
    controller.resumeCamera();
    controller.scannedDataStream.listen((scanData) {
      setState(() {
        log(scanData.toString());
        result = scanData;
        controller.pauseCamera();
        if (result != null) {
          addqr();
        } else {
          (controller.pauseCamera());
        }

        // Navigator.pop(context);
      });
    });
  }

  @override
  void dispose() {
    controller?.dispose();
    super.dispose();
  }
}
