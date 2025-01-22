// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      username: json['username'] as String,
      avatarUrl: json['avatar_url'] as String?,
      hasPets: json['has_pets'] as bool? ?? false,
      petCount: (json['pet_count'] as num?)?.toInt() ?? 0,
      favoritePosts: (json['favorite_posts'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
      createdAt: DateTime.parse(json['created_at'] as String),
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'username': instance.username,
      'avatar_url': instance.avatarUrl,
      'has_pets': instance.hasPets,
      'pet_count': instance.petCount,
      'favorite_posts': instance.favoritePosts,
      'created_at': instance.createdAt.toIso8601String(),
    };
