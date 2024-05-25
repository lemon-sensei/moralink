import 'package:json_annotation/json_annotation.dart';
import 'package:moralink/models/event_category.dart';
import 'package:moralink/models/location.dart';

part 'event.g.dart'; // Generated code will be written to this file

@JsonSerializable()
class Event {
  final String id;
  final String title;
  final String description;
  final DateTime startDate;
  final DateTime endDate;
  final Location location;
  final EventCategory category;
  final List<String> registeredUsers;

  Event({
    required this.id,
    required this.title,
    required this.description,
    required this.startDate,
    required this.endDate,
    required this.location,
    required this.category,
    required this.registeredUsers,
  });

  factory Event.fromJson(Map<String, dynamic> json) => _$EventFromJson(json);
  Map<String, dynamic> toJson() => _$EventToJson(this);
}