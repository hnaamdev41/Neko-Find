// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_spot.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CatSpot _$CatSpotFromJson(Map<String, dynamic> json) => CatSpot(
      id: json['id'] as String,
      name: json['name'] as String,
      catCount: json['cat_count'] as String,
      nearbyLocation: json['nearby_location'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      imageUrls: (json['image_urls'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      userId: json['user_id'] as String?,
      username: json['username'] as String?,
      createdAt: json['created_at'] == null
          ? null
          : DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$CatSpotToJson(CatSpot instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'cat_count': instance.catCount,
      'nearby_location': instance.nearbyLocation,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'image_urls': instance.imageUrls,
      'user_id': instance.userId,
      'created_at': instance.createdAt.toIso8601String(),
    };
