

import 'package:equatable/equatable.dart';
import 'package:visitorsbook/models/checkqrmodel.dart';
import 'package:visitorsbook/models/commonmodel.dart';
import 'package:visitorsbook/models/visitormodel.dart';

abstract class AddVisitorEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class AddVisitor extends AddVisitorEvent {
  final VisitorModel visitorModel;

  AddVisitor({
    required this.visitorModel,
  });
  @override
  List<Object> get props => [];
}
