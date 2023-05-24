// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'visitormodel.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

VisitorModel _$VisitorModelFromJson(Map<String, dynamic> json) => VisitorModel(
      visitorname: json['visitorname'] as String?,
      phonenumber: json['phonenumber'] as String?,
      purpose: json['purpose'] as String?,
      persontomeet: json['persontomeet'] as String?,
      vechilenumber: json['vechilenumber'] as String?,
      qrnumber: json['qrnumber'] as String?,
    );

Map<String, dynamic> _$VisitorModelToJson(VisitorModel instance) =>
    <String, dynamic>{
      'visitorname': instance.visitorname,
      'purpose': instance.purpose,
      'phonenumber': instance.phonenumber,
      'persontomeet': instance.persontomeet,
      'vechilenumber': instance.vechilenumber,
      'qrnumber': instance.qrnumber,
    };
