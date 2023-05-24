import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitorsbook/bloc/checkqrbloc/scanqrevent.dart';
import 'package:visitorsbook/bloc/checkqrbloc/scanqrstate.dart';

import 'package:visitorsbook/models/commonmodel.dart';
import 'package:visitorsbook/repositories/repositries.dart';

class CheckQrBloc extends Bloc<CheckQrEvent, CheckQrState> {
  CheckQrBloc() : super(CheckQrinitial()) {
    on<CheckQr>(_checkqr);
  }

  Future _checkqr(CheckQr event, Emitter<CheckQrState> emit) async {
    emit(CheckQrin());
    CommonModel commonModel;

    commonModel = await Repository()
        .scanqr(url: '/inorout', data: event.checkqrModel.toJson());
    if (commonModel.status == true && commonModel.canCheckin == true) {
      Fluttertoast.showToast(
        msg: "checked In Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      emit(CheckQrSuccess(commonModel: commonModel));
    } 

     if (commonModel.status == true && commonModel.canCheckin == false) {
      Fluttertoast.showToast(
        msg: " Checked Out Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      emit(CheckQrSuccessCheckout(commonModel: commonModel));
    } 
    
    else if (commonModel.status == false) {
      Fluttertoast.showToast(
        msg: commonModel.msg.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      emit(CheckQrFailed(error: commonModel.msg.toString()));
    }
  }
}
