import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:visitorsbook/models/visitorlistmodel.dart';
import 'package:visitorsbook/repositories/repositries.dart';

class VisitorListBloc extends Bloc<VisitorListEvent, VisitorListState> {
  VisitorListBloc() : super(VisitorListState()) {
    on<GetVisitorList>(_getVisitorList);
    //on<GetIdentificationVoteList>(_getIdentificationVoteList);
  }

  Future<FutureOr<void>> _getVisitorList(
      GetVisitorList event, Emitter<VisitorListState> emit) async {
    emit(RetreivingVisitorListData());
    VisitorListModel visitorListModel;
    Map data = {
      "page": event.page.toString(),
      "limit": event.limit.toString(),
      "filter": event.filter
    };

    var url = '/visiter/list';
    visitorListModel = await Repository().getVisitorList(url: url, data: data);
    if (visitorListModel.status == true) {
      if (event.page == 1) {
        emit(DeliveredVisitorListSuccess(visitorListModel: visitorListModel));
      } else {
        emit(AddVisitorList(visitorListModel: visitorListModel));
      }
    } else {
      emit(DeliveredVisitorListError(error: visitorListModel.msg.toString()));
    }
  }
}

//events
class VisitorListEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class GetVisitorList extends VisitorListEvent {
  final int? page, limit;
  final String? filter;

  GetVisitorList({this.limit, this.page, this.filter});
}

//states
class VisitorListState extends Equatable {
  @override
  List<Object?> get props => [];
}

class RetreivingVisitorListData extends VisitorListState {}

class VisitorListError extends VisitorListState {
  final String error;
  VisitorListError({required this.error});
}

class RetreivingDeliveredVisitorListData extends VisitorListState {}

class DeliveredVisitorListSuccess extends VisitorListState {
  final VisitorListModel visitorListModel;
  DeliveredVisitorListSuccess({required this.visitorListModel});
}

// class IdentificationVoteSuccess extends CoreState {
//   final IdentificationVoteModel identificationVoteModel;
//   IdentificationVoteSuccess({required this.identificationVoteModel});
// }

class DeliveredVisitorListError extends VisitorListState {
  final String error;
  DeliveredVisitorListError({required this.error});
}

class IdentificationVoteError extends VisitorListState {
  final String error;
  IdentificationVoteError({required this.error});
}

class AddVisitorList extends VisitorListState {
  final VisitorListModel visitorListModel;
  AddVisitorList({required this.visitorListModel});
}
