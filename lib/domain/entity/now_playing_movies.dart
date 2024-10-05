// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import 'package:the_movie_db/domain/entity/date_parser.dart';
import 'package:the_movie_db/domain/entity/movie.dart';

part 'now_playing_movies.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class NowPlayingMovies{
  final Dates dates;
  final int page;
  @JsonKey(name: 'results')
  final List<Movie> movies;
  final int totalResults;
  final int totalPages;

  NowPlayingMovies({required this.dates, required this.page, required this.movies, required this.totalResults, required this.totalPages});

  factory NowPlayingMovies.fromJson(Map<String, dynamic> json) => _$NowPlayingMoviesFromJson(json);

  Map<String, dynamic> toJson() => _$NowPlayingMoviesToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Dates {
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? maximum;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? minimum;
  Dates({
    required this.maximum,
    required this.minimum,
  });

  factory Dates.fromJson(Map<String, dynamic> json) => _$DatesFromJson(json);

  Map<String, dynamic> toJson() => _$DatesToJson(this);
}
