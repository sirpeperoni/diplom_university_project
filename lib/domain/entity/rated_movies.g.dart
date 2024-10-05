// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rated_movies.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RatedMoviesResponse _$RatedMoviesResponseFromJson(Map<String, dynamic> json) =>
    RatedMoviesResponse(
      page: (json['page'] as num).toInt(),
      movies: (json['results'] as List<dynamic>)
          .map((e) => MovieWithRating.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['total_results'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$RatedMoviesResponseToJson(
        RatedMoviesResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.movies.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
    };

MovieWithRating _$MovieWithRatingFromJson(Map<String, dynamic> json) =>
    MovieWithRating(
      posterPath: json['poster_path'] as String?,
      adult: json['adult'] as bool,
      overview: json['overview'] as String,
      releaseDate: parseDateFromString(json['release_date'] as String?),
      genre_ids: (json['genre_ids'] as List<dynamic>)
          .map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num).toInt(),
      originalTitle: json['original_title'] as String,
      originalLanguage: json['original_language'] as String,
      title: json['title'] as String,
      backdropPath: json['backdrop_path'] as String?,
      popularity: (json['popularity'] as num).toDouble(),
      voteCount: (json['vote_count'] as num).toInt(),
      video: json['video'] as bool,
      voteAverage: (json['vote_average'] as num).toDouble(),
      rating: (json['rating'] as num).toInt(),
    );

Map<String, dynamic> _$MovieWithRatingToJson(MovieWithRating instance) =>
    <String, dynamic>{
      'poster_path': instance.posterPath,
      'adult': instance.adult,
      'overview': instance.overview,
      'release_date': instance.releaseDate?.toIso8601String(),
      'genre_ids': instance.genre_ids,
      'id': instance.id,
      'original_title': instance.originalTitle,
      'original_language': instance.originalLanguage,
      'title': instance.title,
      'backdrop_path': instance.backdropPath,
      'popularity': instance.popularity,
      'vote_count': instance.voteCount,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'rating': instance.rating,
    };
