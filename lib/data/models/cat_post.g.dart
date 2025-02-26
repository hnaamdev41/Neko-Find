// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cat_post.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$CatPostImpl _$$CatPostImplFromJson(Map<String, dynamic> json) =>
    _$CatPostImpl(
      id: json['id'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      estimatedAge: json['estimated_age'] as String,
      contactInfo: json['contactinfo'] as String,
      latitude: (json['latitude'] as num).toDouble(),
      longitude: (json['longitude'] as num).toDouble(),
      imageUrls: (json['image_urls'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      createdAt: DateTime.parse(json['created_at'] as String),
      userId: json['user_id'] as String?,
    );

Map<String, dynamic> _$$CatPostImplToJson(_$CatPostImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'estimated_age': instance.estimatedAge,
      'contactinfo': instance.contactInfo,
      'latitude': instance.latitude,
      'longitude': instance.longitude,
      'image_urls': instance.imageUrls,
      'created_at': instance.createdAt.toIso8601String(),
      'user_id': instance.userId,
    };
