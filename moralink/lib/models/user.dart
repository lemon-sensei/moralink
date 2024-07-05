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
  String? _addressLine1;
  String? _addressLine2;
  String? _addressCity;
  String? _addressState;
  String? _addressZipCode;
  String? _addressCountry;
  String? _phone;
  String? _lineId;

  String? get passportNumber => _passportNumber;
  set passportNumber(String? value) {
    _passportNumber = value;
  }

  String? get nameOnPassport => _nameOnPassport;
  set nameOnPassport(String? value) {
    _nameOnPassport = value;
  }

  String? get addressLine1 => _addressLine1;
  set addressLine1(String? value) {
    _addressLine1 = value;
  }

  String? get addressLine2 => _addressLine2;
  set addressLine2(String? value) {
    _addressLine2 = value;
  }

  String? get addressCity => _addressCity;
  set addressCity(String? value) {
    _addressCity = value;
  }

  String? get addressState => _addressState;
  set addressState(String? value) {
    _addressState = value;
  }

  String? get addressZipCode => _addressZipCode;
  set addressZipCode(String? value) {
    _addressZipCode = value;
  }

  String? get addressCountry => _addressCountry;
  set addressCountry(String? value) {
    _addressCountry = value;
  }

  String? get phone => _phone;
  set phone(String? value) {
    _phone = value;
  }

  String? get lineId => _lineId;
  set lineId(String? value) {
    _lineId = value;
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
    addressLine1,
    addressLine2,
    addressCity,
    addressState,
    addressZipCode,
    addressCountry,
    phone,
    lineId,
  }) {
    _passportNumber = passportNumber;
    _nameOnPassport = nameOnPassport;

    _addressLine1 = addressLine1;
    _addressLine2 = addressLine2;
    _addressCity = addressCity;
    _addressState = addressState;
    _addressZipCode = addressZipCode;
    _addressCountry = addressCountry;

    _phone = phone;
    _lineId = lineId;
  }

  factory AppUser.fromJson(Map<String, dynamic> json) => _$AppUserFromJson(json);
  Map<String, dynamic> toJson() => _$AppUserToJson(this);
}