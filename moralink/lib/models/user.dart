import 'package:json_annotation/json_annotation.dart';
import 'package:moralink/models/user_role.dart';

part 'user.g.dart'; // Generated code will be written to this file

@JsonSerializable()
class AppUser {
  final String id;
  final String name;
  final String email;
  final UserRole role;
  final List<String> registeredEvents;

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    required this.role,
    required this.registeredEvents,
  });

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}