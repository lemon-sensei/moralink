import 'package:json_annotation/json_annotation.dart';

part 'location.g.dart'; // Generated code will be written to this file

@JsonSerializable()
class Location {
  final String name;
  final double latitude;
  final double longitude;
  final String address;

  Location({
    required this.name,
    required this.latitude,
    required this.longitude,
    required this.address,
  });

  factory Location.fromJson(Map<String, dynamic> json) => _$LocationFromJson(json);
  Map<String, dynamic> toJson() => _$LocationToJson(this);
}