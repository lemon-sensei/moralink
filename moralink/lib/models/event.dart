import 'package:json_annotation/json_annotation.dart';
import 'package:moralink/models/event_category.dart';

part 'event.g.dart'; // Generated code will be written to this file

@JsonSerializable()
class Event {
  final String id;
  final String title;
  final String description;
  final String thumbnail;
  final DateTime startDate;
  final DateTime endDate;
  final String locationName;
  final String locationAddress;
  final double locationLat;
  final double locationLong;
  final EventCategory category;
  final List<String> registeredUsers;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.thumbnail,
    required this.startDate,
    required this.endDate,
    required this.locationName,
    required this.locationAddress,
    required this.locationLat,
    required this.locationLong,
    required this.category,
    required this.registeredUsers,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}