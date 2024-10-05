// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'package:json_annotation/json_annotation.dart';

import 'package:the_movie_db/domain/entity/discover/genre.dart';

part 'genres.g.dart';

@JsonSerializable(fieldRename: FieldRename.snake, explicitToJson: true)
class Genres {
  List<Genre> genres;
  Genres({
    required this.genres,
  });

  factory Genres.fromJson(Map<String, dynamic> json) => _$GenresFromJson(json);

  Map<String, dynamic> toJson() => _$GenresToJson(this);
}



