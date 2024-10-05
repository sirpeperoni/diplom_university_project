import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entity/date_parser.dart';


part 'rated_movies.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class RatedMoviesResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<MovieWithRating> movies;
  final int totalResults;
  final int totalPages;

  RatedMoviesResponse({
    required this.page,
    required this.movies,
    required this.totalResults,
    required this.totalPages,
  });

  factory RatedMoviesResponse.fromJson(Map<String, dynamic> json) =>
      _$RatedMoviesResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RatedMoviesResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake,  explicitToJson: true)
class MovieWithRating{
  final String? posterPath;
  final bool adult;
  final String overview;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  // ignore: non_constant_identifier_names
  final List<int> genre_ids;
  final int id;
  final String originalTitle;
  final String originalLanguage;
  final String title;
  final String? backdropPath;
  final double popularity;
  final int voteCount;
  final bool video;
  final double voteAverage;
  final int rating;

  MovieWithRating({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.releaseDate,
    // ignore: non_constant_identifier_names
    required this.genre_ids,
    required this.id,
    required this.originalTitle,
    required this.originalLanguage,
    required this.title,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.video,
    required this.voteAverage,
    required this.rating
  });

  factory MovieWithRating.fromJson(Map<String, dynamic> json) => _$MovieWithRatingFromJson(json);

  Map<String, dynamic> toJson() => _$MovieWithRatingToJson(this);


}