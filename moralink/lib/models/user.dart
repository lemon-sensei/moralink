import 'package:json_annotation/json_annotation.dart';
import 'package:moralink/models/user_role.dart';

part 'user.g.dart'; // Generated code will be written to this file

@JsonSerializable()
class AppUser {
  final String id;
  final String name;
  final String email;
  final String? photoUrl;
  final UserRole role;
  final List<String> registeredEvents;
  final List<String> attendedEvents;
  String? _passportNumber;
  String? _nameOnPassport;

  String? get passportNumber => _passportNumber;
  set passportNumber(String? value) {
    _passportNumber = value;
  }

  String? get nameOnPassport => _nameOnPassport;
  set nameOnPassport(String? value) {
    _nameOnPassport = value;
  }

  AppUser({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
    required this.role,
    required this.registeredEvents,
    required this.attendedEvents,
    passportNumber,
    nameOnPassport,
  }) {
    _passportNumber = passportNumber;
    _nameOnPassport = nameOnPassport;
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}