// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_tv_show_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularTvShowResponse _$PopularTvShowResponseFromJson(
        Map<String, dynamic> json) =>
    PopularTvShowResponse(
      page: (json['page'] as num).toInt(),
      shows: (json['results'] as List<dynamic>)
          .map((e) => TvShow.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['total_results'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$PopularTvShowResponseToJson(
        PopularTvShowResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.shows.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
    };
