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
    );

Map<String, dynamic> _$AppUserToJson(AppUser instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'photoUrl': instance.photoUrl,
      'role': _$UserRoleEnumMap[instance.role]!,
      'registeredEvents': instance.registeredEvents,
      'attendedEvents': instance.attendedEvents,
    };

const _$UserRoleEnumMap = {
  UserRole.user: 'user',
  UserRole.admin: 'admin',
};
