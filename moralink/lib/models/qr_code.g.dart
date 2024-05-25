// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'qr_code.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

QRCode _$QRCodeFromJson(Map<String, dynamic> json) => QRCode(
      code: json['code'] as String,
      eventId: json['eventId'] as String,
      userId: json['userId'] as String,
    );

Map<String, dynamic> _$QRCodeToJson(QRCode instance) => <String, dynamic>{
      'code': instance.code,
      'eventId': instance.eventId,
      'userId': instance.userId,
    };
