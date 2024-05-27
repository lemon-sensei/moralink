// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      thumbnail: json['thumbnail'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      locationName: json['locationName'] as String,
      locationAddress: json['locationAddress'] as String,
      locationLat: (json['locationLat'] as num).toDouble(),
      locationLong: (json['locationLong'] as num).toDouble(),
      category: $enumDecode(_$EventCategoryEnumMap, json['category']),
      registeredUsers: (json['registeredUsers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'thumbnail': instance.thumbnail,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'locationName': instance.locationName,
      'locationAddress': instance.locationAddress,
      'locationLat': instance.locationLat,
      'locationLong': instance.locationLong,
      'category': _$EventCategoryEnumMap[instance.category]!,
      'registeredUsers': instance.registeredUsers,
    };

const _$EventCategoryEnumMap = {
  EventCategory.religious: 'religious',
  EventCategory.cultural: 'cultural',
  EventCategory.social: 'social',
  EventCategory.educational: 'educational',
};
