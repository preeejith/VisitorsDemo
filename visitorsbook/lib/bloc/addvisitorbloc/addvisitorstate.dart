
import 'package:equatable/equatable.dart';
import 'package:visitorsbook/models/commonmodel.dart';

abstract class AddVisitorState extends Equatable {
  @override
  List<Object> get props => [];
}

class AddVisitorinitial extends AddVisitorState {}

class AddVisitorin extends AddVisitorState {}

class AddVisitorFailed extends AddVisitorState {
  final String error;
  AddVisitorFailed({required this.error});
  @override
  List<Object> get props => [];
}

class AddVisitorSuccess extends AddVisitorState {
  final CommonModel commonModel;
  AddVisitorSuccess({required this.commonModel});
  @override
  List<Object> get props => [];
}
