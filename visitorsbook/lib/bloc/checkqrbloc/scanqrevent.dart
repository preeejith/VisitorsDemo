

import 'package:equatable/equatable.dart';
import 'package:visitorsbook/models/checkqrmodel.dart';
import 'package:visitorsbook/models/commonmodel.dart';

abstract class CheckQrEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class CheckQr extends CheckQrEvent {
  final CheckQrModel checkqrModel;

  CheckQr({
    required this.checkqrModel,
  });
  @override
  List<Object> get props => [];
}
