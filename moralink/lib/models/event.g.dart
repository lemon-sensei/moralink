// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Event _$EventFromJson(Map<String, dynamic> json) => Event(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      startDate: DateTime.parse(json['startDate'] as String),
      endDate: DateTime.parse(json['endDate'] as String),
      location: Location.fromJson(json['location'] as Map<String, dynamic>),
      category: $enumDecode(_$EventCategoryEnumMap, json['category']),
      registeredUsers: (json['registeredUsers'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$EventToJson(Event instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'startDate': instance.startDate.toIso8601String(),
      'endDate': instance.endDate.toIso8601String(),
      'location': instance.location,
      'category': _$EventCategoryEnumMap[instance.category]!,
      'registeredUsers': instance.registeredUsers,
    };

const _$EventCategoryEnumMap = {
  EventCategory.religious: 'religious',
  EventCategory.cultural: 'cultural',
  EventCategory.social: 'social',
  EventCategory.educational: 'educational',
};
