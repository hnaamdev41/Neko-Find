import 'package:freezed_annotation/freezed_annotation.dart';

part 'cat_post.freezed.dart';
part 'cat_post.g.dart';

@Freezed(toJson: true, fromJson: true)
class CatPost with _$CatPost {
  const factory CatPost({
    required String id,
    required String title,
    required String description,
    @JsonKey(name: 'estimated_age') required String estimatedAge,
    @JsonKey(name: 'contactinfo') required String contactInfo,
    required double latitude,
    required double longitude,
    @JsonKey(name: 'image_urls') required List<String> imageUrls,
    @JsonKey(name: 'created_at') required DateTime createdAt,
    @JsonKey(name: 'user_id') String? userId,
  }) = _CatPost;

  factory CatPost.fromJson(Map<String, dynamic> json) => _$CatPostFromJson(json);
}