
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entity/date_parser.dart';
part 'people_combined_credits.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CombinedCredits{
  List<Actor> cast;
  List<Employee> crew;
  CombinedCredits({
    required this.cast,
    required this.crew,
  });

  factory CombinedCredits.fromJson(Map<String, dynamic> json) =>
      _$CombinedCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$CombinedCreditsToJson(this);
}


@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Actor {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String? originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double voteAverage;
  final double voteCount;
  final String character;
  final String creditId;
  final int? order;
  final String? mediaType;

  Actor({required this.adult, required this.backdropPath, required this.genreIds, required this.id, required this.originalLanguage, required this.originalTitle, required this.overview, required this.popularity, required this.posterPath, required this.releaseDate, required this.title, required this.video, required this.voteAverage, required this.voteCount, required this.character, required this.creditId, required this.order, required this.mediaType});


  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);

  
  Map<String, dynamic> toJson() => _$ActorToJson(this);

}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Employee {
  final bool adult;
  final String? backdropPath;
  final List<int> genreIds;
  final int id;
  final String originalLanguage;
  final String? originalTitle;
  final String overview;
  final double popularity;
  final String? posterPath;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double voteAverage;
  final double voteCount;
  final String creditId;
  final String department;
  final String? mediaType;
  final String job;


  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Employee({required this.adult, required this.backdropPath, required this.genreIds, required this.id, required this.originalLanguage, required this.originalTitle, required this.overview, required this.popularity, required this.posterPath, required this.releaseDate, required this.title, required this.video, required this.voteAverage, required this.voteCount, required this.creditId, required this.department, required this.mediaType, required this.job});


  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}