// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'route.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

InitialRoute _$RouteFromJson(Map<String, dynamic> json) {
  return InitialRoute()
    ..route = json['route'] as String
    ..data = json['data'];
}

Map<String, dynamic> _$RouteToJson(InitialRoute instance) => <String, dynamic>{
      'route': instance.route,
      'data': instance.data,
    };
