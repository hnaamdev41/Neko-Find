// lib/data/models/cat_spot.dart
import 'package:json_annotation/json_annotation.dart';

part 'cat_spot.g.dart';

// lib/data/models/cat_spot.dart
@JsonSerializable()
class CatSpot {
  final String id;
  final String name;
  @JsonKey(name: 'cat_count')
  final String catCount;
  @JsonKey(name: 'nearby_location')
  final String nearbyLocation;
  final double latitude;
  final double longitude;
  @JsonKey(name: 'image_urls')
  final List<String> imageUrls;
  @JsonKey(name: 'user_id')
  final String? userId;
  @JsonKey(includeToJson: false)  // Don't include in JSON for insert/update
  final String? username;
  @JsonKey(name: 'created_at')
  final DateTime createdAt;

  CatSpot({
    required this.id,
    required this.name,
    required this.catCount,
    required this.nearbyLocation,
    required this.latitude,
    required this.longitude,
    this.imageUrls = const [],
    this.userId,
    this.username,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CatSpot.fromJson(Map<String, dynamic> json) => _$CatSpotFromJson(json);
  Map<String, dynamic> toJson() => _$CatSpotToJson(this);
}