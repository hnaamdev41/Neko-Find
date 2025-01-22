// lib/data/models/user.dart
import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String email,
    required String username,
    @JsonKey(name: 'avatar_url') String? avatarUrl,
    @JsonKey(name: 'has_pets') @Default(false) bool hasPets,
    @JsonKey(name: 'pet_count') @Default(0) int petCount,
    @JsonKey(name: 'favorite_posts') @Default([]) List<String> favoritePosts,
    @JsonKey(name: 'created_at') required DateTime createdAt,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}