import 'package:json_annotation/json_annotation.dart';

part 'countries.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Countries {
  @JsonKey(name: 'iso_3166_1')
  final String iso;
  final String englishName;
  final String nativeName;

  Countries({
    required this.iso,
    required this.englishName,
    required this.nativeName
  });

  factory Countries.fromJson(Map<String, dynamic> json) => _$CountriesFromJson(json);

  Map<String, dynamic> toJson() => _$CountriesToJson(this);
}