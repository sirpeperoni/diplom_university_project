// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Details _$DetailsFromJson(Map<String, dynamic> json) => Details(
      images: Images.fromJson(json['images'] as Map<String, dynamic>),
      changeKeys: (json['change_keys'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$DetailsToJson(Details instance) => <String, dynamic>{
      'images': instance.images.toJson(),
      'change_keys': instance.changeKeys,
    };

Images _$ImagesFromJson(Map<String, dynamic> json) => Images(
      baseUrl: json['base_url'] as String,
      secureBaseUrl: json['secure_base_url'] as String,
      backdropSizes: (json['backdrop_sizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      logoSizes: (json['logo_sizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      posterSizes: (json['poster_sizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      profileSizes: (json['profile_sizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      stillSizes: (json['still_sizes'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$ImagesToJson(Images instance) => <String, dynamic>{
      'base_url': instance.baseUrl,
      'secure_base_url': instance.secureBaseUrl,
      'backdrop_sizes': instance.backdropSizes,
      'logo_sizes': instance.logoSizes,
      'poster_sizes': instance.posterSizes,
      'profile_sizes': instance.profileSizes,
      'still_sizes': instance.stillSizes,
    };
