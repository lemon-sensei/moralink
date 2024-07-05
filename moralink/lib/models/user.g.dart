// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AppUser _$AppUserFromJson(Map<String, dynamic> json) => AppUser(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      photoUrl: json['photoUrl'] as String?,
      role: $enumDecode(_$UserRoleEnumMap, json['role']),
      registeredEvents: (json['registeredEvents'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      attendedEvents: (json['attendedEvents'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      passportNumber: json['passportNumber'],
      nameOnPassport: json['nameOnPassport'],
      addressLine1: json['addressLine1'],
      addressLine2: json['addressLine2'],
      addressCity: json['addressCity'],
      addressState: json['addressState'],
      addressZipCode: json['addressZipCode'],
      addressCountry: json['addressCountry'],
      phone: json['phone'],
      lineId: json['lineId'],
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'role': _$UserRoleEnumMap[instance.role]!,
      'registeredEvents': instance.registeredEvents,
      'attendedEvents': instance.attendedEvents,
      'passportNumber': instance.passportNumber,
      'nameOnPassport': instance.nameOnPassport,
      'addressLine1': instance.addressLine1,
      'addressLine2': instance.addressLine2,
      'addressCity': instance.addressCity,
      'addressState': instance.addressState,
      'addressZipCode': instance.addressZipCode,
      'addressCountry': instance.addressCountry,
      'phone': instance.phone,
      'lineId': instance.lineId,
    };

const _$UserRoleEnumMap = {
  UserRole.user: 'user',
  UserRole.admin: 'admin',
};
