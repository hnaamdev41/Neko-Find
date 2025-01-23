// lib/data/models/cat_post.dart
import 'package:json_annotation/json_annotation.dart';

part 'cat_post.g.dart';

@JsonSerializable()
class CatPost {
  final String id;
  final String title;
  final String description;
  @JsonKey(name: 'estimated_age')
  final String estimatedAge;
  @JsonKey(name: 'contact_info')
  final String contactInfo;
  final double latitude;
  final double longitude;
  @JsonKey(name: 'image_urls')
  final List<String> imageUrls;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @JsonKey(name: 'user_id')
  final String? userId;

  CatPost({
    required this.id,
    required this.title,
    required this.description,
    required this.estimatedAge,
    required this.contactInfo,
    required this.latitude,
    required this.longitude,
    required this.imageUrls,
    required this.createdAt,
    this.userId,
  });

  factory CatPost.fromJson(Map<String, dynamic> json) => _$CatPostFromJson(json);
  Map<String, dynamic> toJson() => _$CatPostToJson(this);
}