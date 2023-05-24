import 'package:equatable/equatable.dart';
import 'package:visitorsbook/models/commonmodel.dart';

abstract class CheckQrState extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckQrinitial extends CheckQrState {}

class CheckQrin extends CheckQrState {}

class CheckQrFailed extends CheckQrState {
  final String error;
  CheckQrFailed({required this.error});
  @override
  List<Object> get props => [];
}

class CheckQrSuccess extends CheckQrState {
  final CommonModel commonModel;
  CheckQrSuccess({required this.commonModel});
  @override
  List<Object> get props => [];
}

class CheckQrSuccessCheckout extends CheckQrState {
  final CommonModel commonModel;
  CheckQrSuccessCheckout({required this.commonModel});
  @override
  List<Object> get props => [];
}
