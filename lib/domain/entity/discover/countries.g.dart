// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'countries.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Countries _$CountriesFromJson(Map<String, dynamic> json) => Countries(
      iso: json['iso_3166_1'] as String,
      englishName: json['english_name'] as String,
      nativeName: json['native_name'] as String,
    );

Map<String, dynamic> _$CountriesToJson(Countries instance) => <String, dynamic>{
      'iso_3166_1': instance.iso,
      'english_name': instance.englishName,
      'native_name': instance.nativeName,
    };
