import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/api_client/api_client_exception.dart';
import 'package:the_movie_db/domain/api_client/configuration_api_client.dart';
import 'package:the_movie_db/domain/entity/discover/countries.dart';
import 'package:the_movie_db/domain/local_entity/country_local.dart';
import 'package:the_movie_db/domain/local_entity/genres_local.dart';
import 'package:the_movie_db/domain/services/auth_service.dart';
import 'package:the_movie_db/domain/services/movie_service.dart';
import 'package:the_movie_db/library/Widgets/localized_model.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class DiscoverViewModel extends ChangeNotifier{
  final _discoverService = ConfigurationApiClient();
  final _movieService = MovieService();
  final _authService = AuthService();
  final _localeStorage = LocalizedModelStorage();

  var isChooseGenre = false;
  late List<GenresWithIcon> genres;
  List<GenresWithIcon> toggleGenres = [];

  var isChooseCountries = false;
  late final List<CountryWithIcon> countries;
  List<CountryWithIcon> toggleCountry = [];
  List<CountryWithIcon?> seacrhCountry = [];
  bool isNotSearchInCountryList = false;

  String fromYear = 'Выберите год';
  String toYear = 'Выберите год';
  
  void changeGenre(){
    isChooseGenre = !isChooseGenre;
    notifyListeners();
  }

  void changeCountries(){
    isChooseCountries = !isChooseCountries;
    notifyListeners();
  }



  Future<void> setupLocale(BuildContext context, Locale locale) async {
    if(!_localeStorage.updateLocale(locale)) return;
    //updateData(null, false, false);
    await loadDetails(context);
  }

  Future<void> loadDetails(BuildContext context,) async {
    try{
      final receivedCountries = await _discoverService.getCountries(_localeStorage.localeTag);
      countries = receivedCountries.map((e) => CountryWithIcon(Countries(englishName: e['english_name'], iso: e['iso_3166_1'], nativeName: e['native_name']), false, )).toList();
      seacrhCountry = countries;
      final receivedGenres = await _movieService.getMovieGenres();
      genres = receivedGenres.genres.map((e) => GenresWithIcon(e, false)).toList();
      notifyListeners();
      //updateData(details.details, details.isFavorite, details.isWatchlist);
    } on ApiClientException catch(e) {
      // ignore: use_build_context_synchronously
      _handleApiClientException(e, context);
    }
  }

  void toggleGenre(int index){
    genres[index].choose = !genres[index].choose;
    if(genres[index].choose){
      toggleGenres.add(genres[index]);
    } else {
      toggleGenres.remove(genres[index]);
    }
    notifyListeners();
  }

  void toggleCountryFunc(int index){
    countries[index].choose = !countries[index].choose;
    if(countries[index].choose){
      toggleCountry.add(countries[index]);
    } else {
      toggleCountry.remove(countries[index]);
    }
    notifyListeners();
  }

   void searchCountry(String query){
    if(query.isEmpty){
      seacrhCountry = countries;
      notifyListeners();
      return;
    }
    seacrhCountry = countries.map((e) {
      if(e.country.nativeName.toLowerCase().startsWith(query.toLowerCase())) {
        return e;
      }
      if(e.country.englishName.toLowerCase().startsWith(query.toLowerCase())) {
        return e;
      } 
    }).where((n) => n != null).toList();
    notifyListeners();
   }

   void reset(){
    toggleCountry.clear();
    toggleGenres.cast();
    notifyListeners();
   }

  void onSubmitTap(BuildContext context) {
    final genresString = toggleGenres.map((e) => e.genre.id).join(',');
    final countryString = toggleCountry.map((e) => e.country.iso).join(',');
    final arguments = ScreenArguments(countries: countryString, genres: genresString);
    Navigator.of(context).pushNamed(
      MainNavigationRoutesName.discoverScreenMovieResult,
      arguments: arguments
    );
  }

  void updateData(){
    
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

  void changeYear(String year, int index){
    if(index == 1){
      fromYear = year;
    } else{
      toYear = year;
    }  
    notifyListeners();
  }


}



class ScreenArguments{
  final String genres;
  final String countries;

  ScreenArguments({required this.countries,required this.genres});
}