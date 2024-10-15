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

  double min = 0;
  double max = 10;
  RangeValues currentRangeValues = RangeValues(0, 10);
  String rating = '';

  void changeCurrentRangeValues(RangeValues values){
    currentRangeValues = values;
    min = currentRangeValues.start;
    max = currentRangeValues.end;
    rating = 'От ${min.round()} до ${max.round()}';
    notifyListeners();
  }

  void changeGenre(){
    isChooseGenre = !isChooseGenre;
    notifyListeners();
  }

  void changeCountries(){
    isChooseCountries = !isChooseCountries;
    seacrhCountry = countries;
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
      countries = receivedCountries.map(
        (e) => CountryWithIcon(
          Countries(
            englishName: e['english_name'],
            iso: e['iso_3166_1'],
            nativeName: e['native_name']),
            false, 
          )
      ).toList();
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
    final country = countries.firstWhere((country) => country.country.iso == seacrhCountry[index]?.country.iso);
    final id = countries.indexOf(country);
    countries[id].choose = !countries[id].choose;
    if(countries[id].choose){
      toggleCountry.add(countries[id]);
    } else {
      toggleCountry.remove(countries[id]);
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
    final arguments = ScreenArguments(
      countries: countryString,
      genres: genresString,
      primaryReleaseDateGTE: primaryReleaseDateGTE,
      primaryReleaseDateLTE: primaryReleaseDateLTE,
      voteAverageGte: min,
      voteAverageLte: max
    );
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


  var fromYear = 1887;
  var toYear = DateTime.now().year;
  var selectedFromYear = 1887;
  var selectedToYear = DateTime.now().year;
  var primaryReleaseDateGTE = "1887-01-01";
  var primaryReleaseDateLTE = "${DateTime.now().year}-01-01";
  var primaryRelease = '';
  bool fYear = false;
  bool tYear = false;
  
  void changeFromYear(int newYear){
    fromYear = newYear;
    fYear = true;
    notifyListeners();
  }

  void changeToYear(int newYear){
    toYear = newYear;
    tYear = true;
    notifyListeners();
  }


  void acceptChangeYear(){
    selectedFromYear = fromYear;
    selectedToYear = toYear;

    primaryReleaseDateLTE = "${toYear}-01-01";
    if(selectedFromYear > selectedToYear && fYear){
      fYear = false;
      selectedToYear = fromYear;
      primaryReleaseDateLTE = "${toYear}-01-01";
    }

    primaryReleaseDateGTE = "${fromYear}-01-01";
    if(selectedFromYear > selectedToYear && tYear){
      tYear = false;
      selectedFromYear = toYear;
      primaryReleaseDateGTE = "${fromYear}-01-01";
    }

    primaryRelease = '${selectedFromYear} - ${selectedToYear}';
    notifyListeners();
  }


}



class ScreenArguments{
  final String genres;
  final String countries;
  final String primaryReleaseDateGTE;
  final String primaryReleaseDateLTE;
  final double voteAverageGte;
  final double voteAverageLte;
  ScreenArguments({
    required this.countries,
    required this.genres,
    required this.primaryReleaseDateGTE,
    required this.primaryReleaseDateLTE,
    required this.voteAverageGte,
    required this.voteAverageLte
  });
}


class YearInit{
  final String year;
  final int id;
  YearInit({required this.year, required this.id});
}