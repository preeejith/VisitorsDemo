import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:visitorsbook/bloc/addvisitorbloc/addvisitorevent.dart';
import 'package:visitorsbook/bloc/addvisitorbloc/addvisitorstate.dart';
import 'package:visitorsbook/bloc/checkqrbloc/scanqrevent.dart';
import 'package:visitorsbook/bloc/checkqrbloc/scanqrstate.dart';

import 'package:visitorsbook/models/commonmodel.dart';
import 'package:visitorsbook/repositories/repositries.dart';

class AddVisitorBloc extends Bloc<AddVisitorEvent, AddVisitorState> {
  AddVisitorBloc() : super(AddVisitorinitial()) {
    on<AddVisitor>(_addvisitor);
  }

  Future _addvisitor(AddVisitor event, Emitter<AddVisitorState> emit) async {
    emit(AddVisitorin());
    CommonModel commonModel;

    commonModel = await Repository()
        .scanqr(url: '/visitordetails', data: event.visitorModel.toJson());
    if (commonModel.status == true) {
      Fluttertoast.showToast(
        msg: "Success",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      emit(AddVisitorSuccess(commonModel: commonModel));
    } else if (commonModel.status == false) {
      Fluttertoast.showToast(
        msg: commonModel.msg.toString(),
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
      emit(AddVisitorFailed(error: commonModel.msg.toString()));
    }
  }
}
