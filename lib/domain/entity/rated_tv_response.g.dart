// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rated_tv_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatedTvResponse _$RatedTvResponseFromJson(Map<String, dynamic> json) =>
    RatedTvResponse(
      page: (json['page'] as num).toInt(),
      movies: (json['results'] as List<dynamic>)
          .map((e) => TvWithRating.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['total_results'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$RatedTvResponseToJson(RatedTvResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.movies.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
    };

TvWithRating _$TvWithRatingFromJson(Map<String, dynamic> json) => TvWithRating(
      posterPath: json['poster_path'] as String?,
      adult: json['adult'] as bool,
      overview: json['overview'] as String,
      genreIds: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num).toInt(),
      originalName: json['original_name'] as String,
      originalLanguage: json['original_language'] as String,
      backdropPath: json['backdrop_path'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      voteAverage: (json['vote_average'] as num).toDouble(),
      rating: (json['rating'] as num).toInt(),
      originCountry: (json['origin_country'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      firstAirDate: parseDateFromString(json['first_air_date'] as String?),
      name: json['name'] as String,
    );

Map<String, dynamic> _$TvWithRatingToJson(TvWithRating instance) =>
    <String, dynamic>{
      'backdrop_path': instance.backdropPath,
      'adult': instance.adult,
      'first_air_date': instance.firstAirDate?.toIso8601String(),
      'genre_ids': instance.genreIds,
      'id': instance.id,
      'name': instance.name,
      'origin_country': instance.originCountry,
      'original_language': instance.originalLanguage,
      'original_name': instance.originalName,
      'overview': instance.overview,
      'popularity': instance.popularity,
      'poster_path': instance.posterPath,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'rating': instance.rating,
    };
