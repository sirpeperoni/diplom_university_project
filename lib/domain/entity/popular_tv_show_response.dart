import 'package:json_annotation/json_annotation.dart';
import 'package:the_movie_db/domain/entity/tv_show.dart';

part 'popular_tv_show_response.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class PopularTvShowResponse {
  final int page;
  @JsonKey(name: 'results')
  final List<TvShow> shows;
  final int totalResults;
  final int totalPages;

  PopularTvShowResponse({
    required this.page,
    required this.shows,
    required this.totalResults,
    required this.totalPages,
  });

  factory PopularTvShowResponse.fromJson(Map<String, dynamic> json) =>
      _$PopularTvShowResponseFromJson(json);

  Map<String, dynamic> toJson() => _$PopularTvShowResponseToJson(this);
}