// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'cat_post.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

CatPost _$CatPostFromJson(Map<String, dynamic> json) {
  return _CatPost.fromJson(json);
}

/// @nodoc
mixin _$CatPost {
  String get id => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  @JsonKey(name: 'estimated_age')
  String get estimatedAge => throw _privateConstructorUsedError;
  @JsonKey(name: 'contactinfo')
  String get contactInfo => throw _privateConstructorUsedError;
  double get latitude => throw _privateConstructorUsedError;
  double get longitude => throw _privateConstructorUsedError;
  @JsonKey(name: 'image_urls')
  List<String> get imageUrls => throw _privateConstructorUsedError;
  @JsonKey(name: 'created_at')
  DateTime get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: 'user_id')
  String? get userId => throw _privateConstructorUsedError;

  /// Serializes this CatPost to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of CatPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $CatPostCopyWith<CatPost> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CatPostCopyWith<$Res> {
  factory $CatPostCopyWith(CatPost value, $Res Function(CatPost) then) =
      _$CatPostCopyWithImpl<$Res, CatPost>;
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      @JsonKey(name: 'estimated_age') String estimatedAge,
      @JsonKey(name: 'contactinfo') String contactInfo,
      double latitude,
      double longitude,
      @JsonKey(name: 'image_urls') List<String> imageUrls,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'user_id') String? userId});
}

/// @nodoc
class _$CatPostCopyWithImpl<$Res, $Val extends CatPost>
    implements $CatPostCopyWith<$Res> {
  _$CatPostCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of CatPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? estimatedAge = null,
    Object? contactInfo = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? imageUrls = null,
    Object? createdAt = null,
    Object? userId = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedAge: null == estimatedAge
          ? _value.estimatedAge
          : estimatedAge // ignore: cast_nullable_to_non_nullable
              as String,
      contactInfo: null == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrls: null == imageUrls
          ? _value.imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CatPostImplCopyWith<$Res> implements $CatPostCopyWith<$Res> {
  factory _$$CatPostImplCopyWith(
          _$CatPostImpl value, $Res Function(_$CatPostImpl) then) =
      __$$CatPostImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String title,
      String description,
      @JsonKey(name: 'estimated_age') String estimatedAge,
      @JsonKey(name: 'contactinfo') String contactInfo,
      double latitude,
      double longitude,
      @JsonKey(name: 'image_urls') List<String> imageUrls,
      @JsonKey(name: 'created_at') DateTime createdAt,
      @JsonKey(name: 'user_id') String? userId});
}

/// @nodoc
class __$$CatPostImplCopyWithImpl<$Res>
    extends _$CatPostCopyWithImpl<$Res, _$CatPostImpl>
    implements _$$CatPostImplCopyWith<$Res> {
  __$$CatPostImplCopyWithImpl(
      _$CatPostImpl _value, $Res Function(_$CatPostImpl) _then)
      : super(_value, _then);

  /// Create a copy of CatPost
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? title = null,
    Object? description = null,
    Object? estimatedAge = null,
    Object? contactInfo = null,
    Object? latitude = null,
    Object? longitude = null,
    Object? imageUrls = null,
    Object? createdAt = null,
    Object? userId = freezed,
  }) {
    return _then(_$CatPostImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      title: null == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      estimatedAge: null == estimatedAge
          ? _value.estimatedAge
          : estimatedAge // ignore: cast_nullable_to_non_nullable
              as String,
      contactInfo: null == contactInfo
          ? _value.contactInfo
          : contactInfo // ignore: cast_nullable_to_non_nullable
              as String,
      latitude: null == latitude
          ? _value.latitude
          : latitude // ignore: cast_nullable_to_non_nullable
              as double,
      longitude: null == longitude
          ? _value.longitude
          : longitude // ignore: cast_nullable_to_non_nullable
              as double,
      imageUrls: null == imageUrls
          ? _value._imageUrls
          : imageUrls // ignore: cast_nullable_to_non_nullable
              as List<String>,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as DateTime,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CatPostImpl implements _CatPost {
  const _$CatPostImpl(
      {required this.id,
      required this.title,
      required this.description,
      @JsonKey(name: 'estimated_age') required this.estimatedAge,
      @JsonKey(name: 'contactinfo') required this.contactInfo,
      required this.latitude,
      required this.longitude,
      @JsonKey(name: 'image_urls') required final List<String> imageUrls,
      @JsonKey(name: 'created_at') required this.createdAt,
      @JsonKey(name: 'user_id') this.userId})
      : _imageUrls = imageUrls;

  factory _$CatPostImpl.fromJson(Map<String, dynamic> json) =>
      _$$CatPostImplFromJson(json);

  @override
  final String id;
  @override
  final String title;
  @override
  final String description;
  @override
  @JsonKey(name: 'estimated_age')
  final String estimatedAge;
  @override
  @JsonKey(name: 'contactinfo')
  final String contactInfo;
  @override
  final double latitude;
  @override
  final double longitude;
  final List<String> _imageUrls;
  @override
  @JsonKey(name: 'image_urls')
  List<String> get imageUrls {
    if (_imageUrls is EqualUnmodifiableListView) return _imageUrls;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_imageUrls);
  }

  @override
  @JsonKey(name: 'created_at')
  final DateTime createdAt;
  @override
  @JsonKey(name: 'user_id')
  final String? userId;

  @override
  String toString() {
    return 'CatPost(id: $id, title: $title, description: $description, estimatedAge: $estimatedAge, contactInfo: $contactInfo, latitude: $latitude, longitude: $longitude, imageUrls: $imageUrls, createdAt: $createdAt, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CatPostImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.estimatedAge, estimatedAge) ||
                other.estimatedAge == estimatedAge) &&
            (identical(other.contactInfo, contactInfo) ||
                other.contactInfo == contactInfo) &&
            (identical(other.latitude, latitude) ||
                other.latitude == latitude) &&
            (identical(other.longitude, longitude) ||
                other.longitude == longitude) &&
            const DeepCollectionEquality()
                .equals(other._imageUrls, _imageUrls) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      title,
      description,
      estimatedAge,
      contactInfo,
      latitude,
      longitude,
      const DeepCollectionEquality().hash(_imageUrls),
      createdAt,
      userId);

  /// Create a copy of CatPost
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$CatPostImplCopyWith<_$CatPostImpl> get copyWith =>
      __$$CatPostImplCopyWithImpl<_$CatPostImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CatPostImplToJson(
      this,
    );
  }
}

abstract class _CatPost implements CatPost {
  const factory _CatPost(
      {required final String id,
      required final String title,
      required final String description,
      @JsonKey(name: 'estimated_age') required final String estimatedAge,
      @JsonKey(name: 'contactinfo') required final String contactInfo,
      required final double latitude,
      required final double longitude,
      @JsonKey(name: 'image_urls') required final List<String> imageUrls,
      @JsonKey(name: 'created_at') required final DateTime createdAt,
      @JsonKey(name: 'user_id') final String? userId}) = _$CatPostImpl;

  factory _CatPost.fromJson(Map<String, dynamic> json) = _$CatPostImpl.fromJson;

  @override
  String get id;
  @override
  String get title;
  @override
  String get description;
  @override
  @JsonKey(name: 'estimated_age')
  String get estimatedAge;
  @override
  @JsonKey(name: 'contactinfo')
  String get contactInfo;
  @override
  double get latitude;
  @override
  double get longitude;
  @override
  @JsonKey(name: 'image_urls')
  List<String> get imageUrls;
  @override
  @JsonKey(name: 'created_at')
  DateTime get createdAt;
  @override
  @JsonKey(name: 'user_id')
  String? get userId;

  /// Create a copy of CatPost
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$CatPostImplCopyWith<_$CatPostImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
