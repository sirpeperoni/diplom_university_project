import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entity/date_parser.dart';


part 'rated_tv_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class RatedTvResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<TvWithRating> movies;
  final int totalResults;
  final int totalPages;

  RatedTvResponse({
    required this.page,
    required this.movies,
    required this.totalResults,
    required this.totalPages,
  });

  factory RatedTvResponse.fromJson(Map<String, dynamic> json) =>
      _$RatedTvResponseFromJson(json);

  Map<String, dynamic> toJson() => _$RatedTvResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake,  explicitToJson: true)
class TvWithRating{
  final String? backdropPath;
  final bool adult;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? firstAirDate;
  final List<int> genreIds;
  final int id;
  final String name;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String? posterPath;
  final double voteAverage;
  final int voteCount;
  final int rating;

  TvWithRating({
    required this.posterPath,
    required this.adult,
    required this.overview,
    required this.genreIds,
    required this.id,
    required this.originalName,
    required this.originalLanguage,
    required this.backdropPath,
    required this.popularity,
    required this.voteCount,
    required this.voteAverage,
    required this.rating,
    required this.originCountry,
    required this.firstAirDate,
    required this.name
  });

  factory TvWithRating.fromJson(Map<String, dynamic> json) => _$TvWithRatingFromJson(json);

  Map<String, dynamic> toJson() => _$TvWithRatingToJson(this);


}