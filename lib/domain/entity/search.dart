import 'package:json_annotation/json_annotation.dart';



part 'search.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Search {
    int page;
    List<Result> results;
    int totalPages;
    int totalResults;

    Search({
        required this.page,
        required this.results,
        required this.totalPages,
        required this.totalResults,
    });
    factory Search.fromJson(Map<String, dynamic> json) =>
      _$SearchFromJson(json);

  Map<String, dynamic> toJson() => _$SearchToJson(this);

}
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Result {
    String? backdropPath;
    int id;
    String? name;
    String? originalName;
    String? overview;
    String? posterPath;
    MediaType mediaType;
    bool adult;
    String? originalLanguage;
    List<int>? genreIds;
    double popularity;
    DateTime? firstAirDate;
    double? voteAverage;
    int? voteCount;
    List<String>? originCountry;
    String? title;
    String? originalTitle;
    DateTime? releaseDate;
    bool? video;
    int? gender;
    String? knownForDepartment;
    String? profilePath;
    List<Result>? knownFor;

    Result({
        this.backdropPath,
        required this.id,
        this.name,
        this.originalName,
        this.overview,
        this.posterPath,
        required this.mediaType,
        required this.adult,
        this.originalLanguage,
        this.genreIds,
        required this.popularity,
        this.firstAirDate,
        this.voteAverage,
        this.voteCount,
        this.originCountry,
        this.title,
        this.originalTitle,
        this.releaseDate,
        this.video,
        this.gender,
        this.knownForDepartment,
        this.profilePath,
        this.knownFor,
    });
  factory Result.fromJson(Map<String, dynamic> json) =>
      _$ResultFromJson(json);

  Map<String, dynamic> toJson() => _$ResultToJson(this);
}

enum MediaType {
    movie,
    person,
    tv
}


