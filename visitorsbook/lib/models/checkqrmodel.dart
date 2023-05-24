import 'package:json_annotation/json_annotation.dart';
part 'checkqrmodel.g.dart';


@JsonSerializable()
class CheckQrModel {
  String? qrnumber;
  

  CheckQrModel({this.qrnumber});
  factory CheckQrModel.fromJson(Map<String, dynamic> data) =>
      _$CheckQrModelFromJson(data);

  Map<String, dynamic> toJson() => _$CheckQrModelToJson(this);
}
