import 'package:json_annotation/json_annotation.dart';


part 'people_details.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake)
class People{
  final bool adult;
  final List<String>? alsoKnownAs;
  final String biography;
  @JsonKey(fromJson: _parseDateFromString)
  final DateTime? birthday;
  @JsonKey(fromJson: _parseDateFromString)
  final DateTime? deathhday;
  final int gender;
  final String homepage;
  final int id;
  final String imdbId;
  final String knownForDepartment;
  final String name;
  final String placeOfBirth;
  final double popularity;
  final String profilePath;

  People({
    required this.adult,
    required this.alsoKnownAs,
    required this.biography,
    required this.birthday,
    required this.deathhday,
    required this.gender,
    required this.homepage,
    required this.id,
    required this.imdbId,
    required this.knownForDepartment,
    required this.name, 
    required this.placeOfBirth, 
    required this.popularity, 
    required this.profilePath
  });



  factory People.fromJson(Map<String, dynamic> json) => _$PeopleFromJson(json);

 
  Map<String, dynamic> toJson() => _$PeopleToJson(this);

  static DateTime? _parseDateFromString(String? rawDate) {
    if (rawDate == null || rawDate.isEmpty) return null;
    return DateTime.tryParse(rawDate);
  }
}