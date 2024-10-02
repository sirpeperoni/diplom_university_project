import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/api_client/api_client_exception.dart';
import 'package:the_movie_db/domain/entity/tv_show_details.dart';
import 'package:the_movie_db/domain/services/auth_service.dart';
import 'package:the_movie_db/domain/services/tv_show_service.dart';
import 'package:the_movie_db/library/Widgets/localized_model.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';


class TvShowDetailsPosterData {
  final String? backdorPath;
  final String? posterPath;


   TvShowDetailsPosterData({
    this.backdorPath,
    this.posterPath,
  });
   TvShowDetailsPosterData copyWith({
    String? backdropPath,
    String? posterPath,
    bool? isFavorite,
  }) {
    return TvShowDetailsPosterData(
      backdorPath: backdropPath ?? backdorPath,
      posterPath: posterPath ?? this.posterPath,
    );
  }
}

class TvShowDetailsNameData{
  final String? name;
  final String year;

  TvShowDetailsNameData({required this.name, required this.year});
}

class TvShowDetailsScoreData{
  final double voteAverage;
  final String? trailerKey;

  TvShowDetailsScoreData({required this.voteAverage, this.trailerKey});
}

class TvShowDetailsPeopleData{
  final String name;
  final String job;

  TvShowDetailsPeopleData({required this.name, required this.job});
}

class TvShowDetailsActorData{
  final String name;
  final String character;
  final String? profilePath;
  final int id;
  TvShowDetailsActorData({required this.name, required this.character, this.profilePath, required this.id});

}

class TvShowDetailsData {
  String name = "";
  bool isLoading = true;
  String overview = "";
  TvShowDetailsPosterData posterData = TvShowDetailsPosterData();
  TvShowDetailsNameData nameData = TvShowDetailsNameData(name: '', year: '');
  TvShowDetailsScoreData scoreData = TvShowDetailsScoreData(voteAverage: 0);
  String summary = '';
  List<List<TvShowDetailsPeopleData>> peopleData = const <List<TvShowDetailsPeopleData>>[];
  List<TvShowDetailsActorData> actorsData = const <TvShowDetailsActorData>[];
}



class TvShowDetailsModel extends ChangeNotifier{
  final _tvShowService = TvShowService();
  final _authService = AuthService();  
  final int seriesId;
  final data = TvShowDetailsData();
  final _localeStorage = LocalizedModelStorage();
  late DateFormat _dateFormat;
  Future<void>? Function()? onSessionExpired;


  TvShowDetailsModel(this.seriesId);

  Future<void> setupLocale(BuildContext context, Locale locale) async {
    if(!_localeStorage.updateLocale(locale)) return;
    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    updateData(null);
    await loadDetails(context);
  }

  void updateData(TvShowDetails? details){
    data.name = details?.name ?? "Загрузка...";
    data.isLoading = details == null;
    if(details == null){
      notifyListeners();
      return;
    }
    data.overview = details.overview;

    data.posterData = TvShowDetailsPosterData(
      posterPath: details.posterPath, 
      backdorPath: details.backdropPath, 
    );
    var year = details.firstAirDate?.year.toString();
    year = year != null ? ' ($year)' : '';
    data.nameData = TvShowDetailsNameData(name: details.name, year: year);
    final videos = details.videos.results
        .where((video) => video.type == 'Trailer' && video.site == 'YouTube');
    final trailerKey = videos.isNotEmpty == true ? videos.first.key : null;
    data.scoreData = TvShowDetailsScoreData(voteAverage: details.voteAverage * 10, trailerKey: trailerKey);
    data.summary = makeSummary(details);
    data.peopleData = makePeopleData(details);
    data.actorsData = details.credits.cast.map(
      (e) => TvShowDetailsActorData(
        name: e.name, 
        character: e.character, 
        profilePath: e.profilePath,
        id: e.id
    )).toList();
    notifyListeners();
  }

  String makeSummary(TvShowDetails details){
    final releaseDate = details.firstAirDate;
    var texts = <String>[];
    
    if(releaseDate != null ){
      texts.add(_dateFormat.format(releaseDate)); 
    }
    if(details.productionCompanies.isNotEmpty){
      texts.add('(${details.productionCompanies.first.originCountry})');
    }
    dynamic seasons = details.seasons.length;
    if(seasons == 1){
      seasons = "$seasons сезон";
    } else if(seasons < 5){
      seasons = "$seasons сезона";
    } else {
      seasons = "$seasons сезонов";
    }
    texts.add(seasons);
    if(details.genres.isNotEmpty){
      var genresNames = <String>[];
      for(var genre in details.genres){
      genresNames.add(genre.name);
      }
      texts.add(genresNames.join(', '));
    }
    return texts.join(' ');
  }

  List<List<TvShowDetailsPeopleData>> makePeopleData(TvShowDetails details){
    var crew = details.credits.crew
        .map((e) => TvShowDetailsPeopleData(name: e.name, job: e.job))
        .toList();
    crew = crew.length > 4 ? crew.sublist(0, 4) : crew;
    var crewChunks = <List<TvShowDetailsPeopleData>>[];
    for(var i = 0; i < crew.length; i+=2){
      crewChunks.add(
        crew.sublist(i, i+2 > crew.length ? crew.length : i + 2)
      );
    }
    return crewChunks;
  }

  Future<void> loadDetails(BuildContext context) async {
    try{
      final details = await _tvShowService.loadDetails(locale: _localeStorage.localeTag, seriesId: seriesId);
      updateData(details);
    } on ApiClientException catch(e) {
      // ignore: use_build_context_synchronously
      _handleApiClientException(e, context);
    }
  }


  void onPersonTapInTvShowDetails(BuildContext context, int id){
    Navigator.of(context).pushNamed(
      MainNavigationRoutesName.personsScreenDetails,
      arguments: id,
    );
  }

  void _handleApiClientException(ApiClientException exeption, BuildContext context){
      switch (exeption.type) {
        case ApiClientExceptionType.sessionExpired:
          _authService.logout();
          MainNavigation.resetNavigation(context);
          break;
        default:
          // ignore: avoid_print
          print(exeption);
      }
  }
}