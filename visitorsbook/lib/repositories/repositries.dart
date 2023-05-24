// ignore_for_file: non_constant_identifier_names


import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitorsbook/data/webclient.dart';
import 'package:visitorsbook/models/commonmodel.dart';
import 'package:visitorsbook/models/usermodel.dart';
import 'package:visitorsbook/models/visitorlistmodel.dart';

class Repository {
  Future<UserModel> login({required String url, dynamic data}) async {
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.none) {
      Fluttertoast.showToast(
        msg: "No internet connection",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    }
    final dynamic response = await WebClient.post(url, data);
    final UserModel userModel = UserModel.fromJson(response);

    return userModel;
  }

   Future<CommonModel> scanqr(
      {required String url,dynamic data}) async {
    final response = await WebClient.post(url,data);
    final CommonModel dataModel = CommonModel.fromJson(response);

    return dataModel;
  }
  Future<VisitorListModel> getVisitorList(
      {required String url,dynamic data}) async {
    final response = await WebClient.post(url,data);
    final VisitorListModel dataModel = VisitorListModel.fromJson(response);

    return dataModel;
  }

   
}
