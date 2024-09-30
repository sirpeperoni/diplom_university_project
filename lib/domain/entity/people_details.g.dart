// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'people_details.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

People _$PeopleFromJson(Map<String, dynamic> json) => People(
      adult: json['adult'] as bool,
      alsoKnownAs: (json['also_known_as'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      biography: json['biography'] as String,
      birthday: People._parseDateFromString(json['birthday'] as String?),
      deathhday: People._parseDateFromString(json['deathhday'] as String?),
      gender: (json['gender'] as num).toInt(),
      homepage: json['homepage'] as String,
      id: (json['id'] as num).toInt(),
      imdbId: json['imdb_id'] as String,
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      placeOfBirth: json['place_of_birth'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String,
    );

Map<String, dynamic> _$PeopleToJson(People instance) => <String, dynamic>{
      'adult': instance.adult,
      'also_known_as': instance.alsoKnownAs,
      'biography': instance.biography,
      'birthday': instance.birthday?.toIso8601String(),
      'deathhday': instance.deathhday?.toIso8601String(),
      'gender': instance.gender,
      'homepage': instance.homepage,
      'id': instance.id,
      'imdb_id': instance.imdbId,
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'place_of_birth': instance.placeOfBirth,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
    };
