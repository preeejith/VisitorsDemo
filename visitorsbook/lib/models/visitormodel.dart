import 'package:json_annotation/json_annotation.dart';
part 'visitormodel.g.dart';

@JsonSerializable()
class VisitorModel {
  String? visitorname;
  String? purpose;
  String? phonenumber;
  String? persontomeet;
  String? vechilenumber;
  String? qrnumber;

  VisitorModel(
      {this.visitorname,
      this.phonenumber,
      this.purpose,
      this.persontomeet,
      this.vechilenumber,
      this.qrnumber});
  factory VisitorModel.fromJson(Map<String, dynamic> data) =>
      _$VisitorModelFromJson(data);

  Map<String, dynamic> toJson() => _$VisitorModelToJson(this);
}
