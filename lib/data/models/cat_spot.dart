// lib/data/models/cat_spot.dart
import 'package:json_annotation/json_annotation.dart';

part 'cat_spot.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)  // Add this line to handle snake_case
class CatSpot {
  final String id;
  final String name;
  final String catCount;
  final String nearbyLocation;
  final double latitude;
  final double longitude;
  final String? imageUrl;
  final DateTime createdAt;

  CatSpot({
    required this.id,
    required this.name,
    required this.catCount,
    required this.nearbyLocation,
    required this.latitude,
    required this.longitude,
    this.imageUrl,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  factory CatSpot.fromJson(Map<String, dynamic> json) => _$CatSpotFromJson(json);
  Map<String, dynamic> toJson() => _$CatSpotToJson(this);
}