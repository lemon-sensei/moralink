import 'package:json_annotation/json_annotation.dart';

part 'qr_code.g.dart'; // Generated code will be written to this file

@JsonSerializable()
class QRCode {
  final String code;
  final String eventId;
  final String userId;

  QRCode({
    required this.code,
    required this.eventId,
    required this.userId,
  });

  factory QRCode.fromJson(Map<String, dynamic> json) => _$QRCodeFromJson(json);
  Map<String, dynamic> toJson() => _$QRCodeToJson(this);
}