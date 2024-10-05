// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entity/date_parser.dart';
import 'package:the_movie_db/domain/entity/discover/genre.dart';
part 'tv_show_details.g.dart';
@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowDetails{
  final bool adult;
  final String? backdropPath;
  final List<CreatedBy>? createdBy;
  final List<int> episodeRunTime;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? firstAirDate;
  final List<Genre> genres;
  final String? homepage;
  final int id;
  final bool inProduction;
  final List<String> languages;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? lastAirDate;
  final LastEpisodeToAir lastEpisodeToAir;
  final String? name;
  final NextEpisodeToAir? nextEpisodeToAir;
  final List<Networks> networks;
  final int numberOfEpisodes;
  final int numberOfSeasons;
  final List<String> originCountry;
  final String originalLanguage;
  final String originalName;
  final String overview;
  final double popularity;
  final String posterPath;
  final List<ProductionCompanie> productionCompanies;
  final List<ProductionCountrie> productionCountries;
  final List<Season> seasons;
  final List<SpokenLanguage> spokenLanguages;
  final String status;
  final String tagline;
  final String type;
  final double voteAverage;
  final int voteCount;
  final TvShowDetailsCredits credits;
  final MovieDetailsVideos videos;
  TvShowDetails({required this.adult, required this.credits, required this.videos, required this.backdropPath, required this.createdBy, required this.episodeRunTime, required this.firstAirDate, required this.genres, required this.homepage, required this.id, required this.inProduction, required this.languages, required this.lastAirDate, required this.lastEpisodeToAir, required this.name, required this.nextEpisodeToAir, required this.networks, required this.numberOfEpisodes, required this.numberOfSeasons, required this.originCountry, required this.originalLanguage, required this.originalName, required this.overview, required this.popularity, required this.posterPath, required this.productionCompanies, required this.productionCountries, required this.seasons, required this.spokenLanguages, required this.status, required this.tagline, required this.type, required this.voteAverage, required this.voteCount});



  factory TvShowDetails.fromJson(Map<String, dynamic> json) => _$TvShowDetailsFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowDetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class NextEpisodeToAir {
  final int id;
  final String name;
  final String overview;
  // ignore: non_constant_identifier_names
  final double vote_average;
  final int voteCount;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? airDate;
  final int episodeNumber;
  final String episodeType;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;

  // ignore: non_constant_identifier_names
  NextEpisodeToAir({required this.id, required this.name, required this.overview, required this.vote_average, required this.voteCount, required this.airDate, required this.episodeNumber, required this.episodeType, required this.productionCode, required this.runtime, required this.seasonNumber, required this.showId, required this.stillPath});

  factory NextEpisodeToAir.fromJson(Map<String, dynamic> json) => _$NextEpisodeToAirFromJson(json);

  Map<String, dynamic> toJson() => _$NextEpisodeToAirToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class CreatedBy {
  final int id;
  final String creditId;
  final String name;
  final int gender;
  final String? profilePath;
  CreatedBy({
    required this.id,
    required this.creditId,
    required this.name,
    required this.gender,
    required this.profilePath,
  });

  factory CreatedBy.fromJson(Map<String, dynamic> json) => _$CreatedByFromJson(json);

  Map<String, dynamic> toJson() => _$CreatedByToJson(this);
}




@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class LastEpisodeToAir {
  final int id;
  final String name;
  final String overview;
  final double voteAverage;
  final int voteCount;
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? airDate;
  final int episodeNumber;
  final String productionCode;
  final int? runtime;
  final int seasonNumber;
  final int showId;
  final String? stillPath;

  LastEpisodeToAir({required this.id, required this.name, required this.overview, required this.voteAverage, required this.voteCount, required this.airDate, required this.episodeNumber, required this.productionCode, required this.runtime, required this.seasonNumber, required this.showId, required this.stillPath});
  
  factory LastEpisodeToAir.fromJson(Map<String, dynamic> json) => _$LastEpisodeToAirFromJson(json);

  Map<String, dynamic> toJson() => _$LastEpisodeToAirToJson(this);

}


@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Networks {
  final int id;
  final String logoPath;
  final String name;
  final String originCountry;

  Networks({required this.id, required this.logoPath, required this.name, required this.originCountry});

  factory Networks.fromJson(Map<String, dynamic> json) => _$NetworksFromJson(json);

  Map<String, dynamic> toJson() => _$NetworksToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProductionCompanie {
  final int id;
  final String? logoPath;
  final String name;
  final String originCountry;
  ProductionCompanie({
    required this.id,
    required this.logoPath,
    required this.name,
    required this.originCountry,
  });

  factory ProductionCompanie.fromJson(Map<String, dynamic> json) =>
      _$ProductionCompanieFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCompanieToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class ProductionCountrie {
  @JsonKey(name:'iso_3166_1')
  final String iso;
  final String name;
  ProductionCountrie({
    required this.iso,
    required this.name,
  });

  factory ProductionCountrie.fromJson(Map<String, dynamic> json) =>
      _$ProductionCountrieFromJson(json);

  Map<String, dynamic> toJson() => _$ProductionCountrieToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class SpokenLanguage {
  @JsonKey(name: 'iso_639_1')
  final String iso;
  final String name;

  SpokenLanguage({
    required this.iso,
    required this.name,
  });
  factory SpokenLanguage.fromJson(Map<String, dynamic> json) =>
      _$SpokenLanguageFromJson(json);

  Map<String, dynamic> toJson() => _$SpokenLanguageToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Season {
  @JsonKey(fromJson: parseDateFromString)
  final DateTime? airDate;
  final int episodeCount;
  final int id;
  final String name;
  final String overview;
  final String? posterPath;
  final int seasonNumber;
  final int voteAverage;

  Season({required this.airDate, required this.episodeCount, required this.id, required this.name, required this.overview, required this.posterPath, required this.seasonNumber, required this.voteAverage});

  factory Season.fromJson(Map<String, dynamic> json) =>
      _$SeasonFromJson(json);

  Map<String, dynamic> toJson() => _$SeasonToJson(this);
}




@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowDetailsCredits {
  final List<Actor> cast;
  final List<Employee> crew;
  TvShowDetailsCredits({
    required this.cast,
    required this.crew,
  });

  factory TvShowDetailsCredits.fromJson(Map<String, dynamic> json) =>
      _$TvShowDetailsCreditsFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowDetailsCreditsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Actor {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final int? castId;
  final String character;
  final String creditId;
  final int order;
  Actor({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.castId,
    required this.character,
    required this.creditId,
    required this.order,
  });

  factory Actor.fromJson(Map<String, dynamic> json) => _$ActorFromJson(json);

  Map<String, dynamic> toJson() => _$ActorToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Employee {
  final bool adult;
  final int? gender;
  final int id;
  final String knownForDepartment;
  final String name;
  final String originalName;
  final double popularity;
  final String? profilePath;
  final String creditId;
  final String department;
  final String job;
  Employee({
    required this.adult,
    required this.gender,
    required this.id,
    required this.knownForDepartment,
    required this.name,
    required this.originalName,
    required this.popularity,
    required this.profilePath,
    required this.creditId,
    required this.department,
    required this.job,
  });

  factory Employee.fromJson(Map<String, dynamic> json) =>
      _$EmployeeFromJson(json);

  Map<String, dynamic> toJson() => _$EmployeeToJson(this);
}


@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class MovieDetailsVideos {
  final List<TvShowDetailsVideosResult> results;
  MovieDetailsVideos({
    required this.results,
  });

  factory MovieDetailsVideos.fromJson(Map<String, dynamic> json) =>
      _$MovieDetailsVideosFromJson(json);

  Map<String, dynamic> toJson() => _$MovieDetailsVideosToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class TvShowDetailsVideosResult {
  final String id;
  @JsonKey(name: 'iso_639_1')
  final String iso6391;
  @JsonKey(name: 'iso_3166_1')
  final String iso31661;
  final String key;
  final String name;
  final String site;
  final int size;
  final String type;
  TvShowDetailsVideosResult({
    required this.id,
    required this.iso6391,
    required this.iso31661,
    required this.key,
    required this.name,
    required this.site,
    required this.size,
    required this.type,
  });

  factory TvShowDetailsVideosResult.fromJson(Map<String, dynamic> json) =>
      _$TvShowDetailsVideosResultFromJson(json);

  Map<String, dynamic> toJson() => _$TvShowDetailsVideosResultToJson(this);
}