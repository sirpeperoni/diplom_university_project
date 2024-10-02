
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entity/date_parser.dart';
part 'popular_people_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularPeopleResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<ActorInList> people;
  final int totalResults;
  final int totalPages;

  PopularPeopleResponse({
    required this.page,
    required this.people,
    required this.totalResults,
    required this.totalPages,
  });

  factory PopularPeopleResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularPeopleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularPeopleResponseToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ActorInList {
  final bool? adult;
  final int? gender;
  final int id;
  final List<KnownFor?>? knownFor;
  final String knownForDepartment;
  final String name;
  final String? originalName;
  final double popularity;
  final String? profilePath;

  factory ActorInList.fromJson(Map<String, dynamic> json) =>
      _$ActorInListFromJson(json);

  ActorInList({required this.adult, required this.gender, required this.id, required this.originalName, required this.knownFor, required this.knownForDepartment, required this.name, required this.popularity, required this.profilePath});

  Map<String, dynamic> toJson() => _$ActorInListToJson(this);
}



@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class KnownFor{
  final bool? adult;
  final String? backdropPath;
  final List<int>? genreIds;
  final List<String>? originCountry;
  final int? id;
  final String? mediaType;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final String? posterPath;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? releaseDate;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  final double? popularity;

  

  factory KnownFor.fromJson(Map<String, dynamic> json) =>
      _$KnownForFromJson(json);

  KnownFor({required this.adult, required this.originCountry, required this.popularity, required this.backdropPath, required this.genreIds, required this.id, required this.mediaType, required this.originalLanguage, required this.originalTitle, required this.overview, required this.posterPath, required this.releaseDate, required this.title, required this.video, required this.voteAverage, required this.voteCount});

  
  Map<String, dynamic> toJson() => _$KnownForToJson(this);


}