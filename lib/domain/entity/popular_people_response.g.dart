// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'popular_people_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PopularPeopleResponse _$PopularPeopleResponseFromJson(
        Map<String, dynamic> json) =>
    PopularPeopleResponse(
      page: (json['page'] as num).toInt(),
      people: (json['results'] as List<dynamic>)
          .map((e) => ActorInList.fromJson(e as Map<String, dynamic>))
          .toList(),
      totalResults: (json['total_results'] as num).toInt(),
      totalPages: (json['total_pages'] as num).toInt(),
    );

Map<String, dynamic> _$PopularPeopleResponseToJson(
        PopularPeopleResponse instance) =>
    <String, dynamic>{
      'page': instance.page,
      'results': instance.people.map((e) => e.toJson()).toList(),
      'total_results': instance.totalResults,
      'total_pages': instance.totalPages,
    };

ActorInList _$ActorInListFromJson(Map<String, dynamic> json) => ActorInList(
      adult: json['adult'] as bool?,
      gender: (json['gender'] as num?)?.toInt(),
      id: (json['id'] as num).toInt(),
      originalName: json['original_name'] as String?,
      knownFor: (json['known_for'] as List<dynamic>?)
          ?.map((e) =>
              e == null ? null : KnownFor.fromJson(e as Map<String, dynamic>))
          .toList(),
      knownForDepartment: json['known_for_department'] as String,
      name: json['name'] as String,
      popularity: (json['popularity'] as num).toDouble(),
      profilePath: json['profile_path'] as String?,
    );

Map<String, dynamic> _$ActorInListToJson(ActorInList instance) =>
    <String, dynamic>{
      'adult': instance.adult,
      'gender': instance.gender,
      'id': instance.id,
      'known_for': instance.knownFor?.map((e) => e?.toJson()).toList(),
      'known_for_department': instance.knownForDepartment,
      'name': instance.name,
      'original_name': instance.originalName,
      'popularity': instance.popularity,
      'profile_path': instance.profilePath,
    };

KnownFor _$KnownForFromJson(Map<String, dynamic> json) => KnownFor(
      adult: json['adult'] as bool?,
      originCountry: (json['origin_country'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      popularity: (json['popularity'] as num?)?.toDouble(),
      backdropPath: json['backdrop_path'] as String?,
      genreIds: (json['genre_ids'] as List<dynamic>?)
          ?.map((e) => (e as num).toInt())
          .toList(),
      id: (json['id'] as num?)?.toInt(),
      mediaType: json['media_type'] as String?,
      originalLanguage: json['original_language'] as String?,
      originalTitle: json['original_title'] as String?,
      overview: json['overview'] as String?,
      posterPath: json['poster_path'] as String?,
      releaseDate: parseDateFromString(json['release_date'] as String?),
      title: json['title'] as String?,
      video: json['video'] as bool?,
      voteAverage: (json['vote_average'] as num?)?.toDouble(),
      voteCount: (json['vote_count'] as num?)?.toInt(),
    );

Map<String, dynamic> _$KnownForToJson(KnownFor instance) => <String, dynamic>{
      'adult': instance.adult,
      'backdrop_path': instance.backdropPath,
      'genre_ids': instance.genreIds,
      'origin_country': instance.originCountry,
      'id': instance.id,
      'media_type': instance.mediaType,
      'original_language': instance.originalLanguage,
      'original_title': instance.originalTitle,
      'overview': instance.overview,
      'poster_path': instance.posterPath,
      'release_date': instance.releaseDate?.toIso8601String(),
      'title': instance.title,
      'video': instance.video,
      'vote_average': instance.voteAverage,
      'vote_count': instance.voteCount,
      'popularity': instance.popularity,
    };
