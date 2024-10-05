import 'package:json_annotation/json_annotation.dart';

part 'details.g.dart';


@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Details {
  final Images images;
  final List<String> changeKeys;

  Details({required this.images, required this.changeKeys});

  factory Details.fromJson(Map<String, dynamic> json) => _$DetailsFromJson(json);

  Map<String, dynamic> toJson() => _$DetailsToJson(this);
}

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Images{
  final String baseUrl;
  final String secureBaseUrl;
  final List<String> backdropSizes;
  final List<String> logoSizes;
  final List<String> posterSizes;
  final List<String> profileSizes;
  final List<String> stillSizes;

  Images({required this.baseUrl, required this.secureBaseUrl, required this.backdropSizes, required this.logoSizes, required this.posterSizes, required this.profileSizes, required this.stillSizes});

  factory Images.fromJson(Map<String, dynamic> json) => _$ImagesFromJson(json);

  Map<String, dynamic> toJson() => _$ImagesToJson(this);
}