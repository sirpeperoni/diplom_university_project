// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'now_playing_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

NowPlayingMovies _$NowPlayingMoviesFromJson(Map<String, dynamic> json) =>
    NowPlayingMovies(
      dates: Dates.fromJson(json['dates'] as Map<String, dynamic>),
      page: (json['page'] as num).toInt(),
      movies: (json['results'] as List<dynamic>)
          .map((e) => Movie.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['total_results'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$NowPlayingMoviesToJson(NowPlayingMovies instance) =>
    <String, dynamic>{
      'dates': instance.dates.toJson(),
      'page': instance.page,
      'results': instance.movies.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
    };

Dates _$DatesFromJson(Map<String, dynamic> json) => Dates(
      maximum: parseDateFromString(json['maximum'] as String?),
      minimum: parseDateFromString(json['minimum'] as String?),
    );

Map<String, dynamic> _$DatesToJson(Dates instance) => <String, dynamic>{
      'maximum': instance.maximum?.toIso8601String(),
      'minimum': instance.minimum?.toIso8601String(),
    };
