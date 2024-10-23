import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:search_choices/search_choices.dart';
import 'package:the_movie_db/domain/entity/search.dart';
import 'package:the_movie_db/domain/services/search_service.dart';
import 'package:the_movie_db/library/Widgets/localized_model.dart';
import 'package:the_movie_db/library/paginator.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

enum MediaType {
    movie,
    person,
    tv
}

class SearchListRowData {
  final int id;
  final String? posterPath;
  final String? title;
  final String? name;
  final String  mediaType;
  final double? popularity;
  final String? releaseDate;
  final String? overview;
  final String? voteAverage;
  final String? voteCount;
  final String? firstAirDate;
  final String? birthday;
  final String? profilePath;
  final String? originalName;

  SearchListRowData({required this.id, required this.posterPath, required this.title, required this.name, required this.mediaType, required this.popularity, required this.releaseDate, required this.overview, required this.voteAverage, required this.voteCount, required this.firstAirDate, required this.birthday, required this.profilePath, required this.originalName});

 

}

class SearchViewModel extends ChangeNotifier{
  late final Paginator<Result> _discoverMoviePaginator;
  final _searchService = SearchService();
  final _localeStorage = LocalizedModelStorage();
  String? _searchQuery;
  late DateFormat _dateFormat;
  Timer? searchDeboubce;
  var _results = <SearchListRowData>[];
  bool isLoading = true;


  List<SearchListRowData> get results => List.unmodifiable(_results);
  bool get isSearchMode{
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }
  
  SearchViewModel(){
    _discoverMoviePaginator = Paginator<Result>((page) async {
      final result = await _searchService.search(page, _localeStorage.localeTag, _searchQuery ?? '');
      return PaginatorLoadResult(data: result.results, currentPage: result.page, totalPage: result.totalPages);
    } );
  }
  Future<void> setupLocale(Locale locale) async {
    if(!_localeStorage.updateLocale(locale)) return;
    _dateFormat = DateFormat.yMMMMd(_localeStorage.localeTag);
    await resetList();
  }

  Future<void> resetList() async {
    await _discoverMoviePaginator.reset();
    _results.clear();
    await _loadNextPage();
  }

  Future<void> _loadNextPage() async {
    await _discoverMoviePaginator.loadNextPage();
    _results = _discoverMoviePaginator.data.map(_makeRowData).toList();  
    isLoading = false; 
    notifyListeners();
  }

  // Future<void> search(String text) async {
  //     isLoading = true;
  //     searchDeboubce?.cancel();
  //     searchDeboubce = Timer(const Duration(milliseconds: 300), () async {
  //       final searchQuery = text.isNotEmpty ? text : null;
  //       if (_searchQuery == searchQuery) return;
  //       _searchQuery = searchQuery;
  //     });
  //     _results.clear();
  //     if(isSearchMode){
  //       await _discoverMoviePaginator.reset();
  //     }
  //     await _loadNextPage();
  //   }
  Future<void> search(String text) async {
    final searchQuery = text.isNotEmpty ? text : null;
    if (_searchQuery == searchQuery) return;
    _searchQuery = searchQuery;
    _results.clear();
    if(isSearchMode){
      await _discoverMoviePaginator.reset();
    }
    await _loadNextPage();
  }

 

  Future<Tuple2<List<DropdownMenuItem>, int>> searchF(String text) async {
    await search(text);
    List<DropdownMenuItem> resultsDropdown = results.map<DropdownMenuItem>((item) => DropdownMenuItem(
      value: item,
      child: Card(
        shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(4),
                        side: const BorderSide(
                          color: Colors.blue,
                          width: 1,
                        ),
                      ),
        margin: const EdgeInsets.all(10),
                      child: Padding(
                        padding: const EdgeInsets.all(6),
                        child: Text(
                            "${item.name}"),
                      ), 
      ))).toList();
    int nbResults = resultsDropdown.length;
    return (Tuple2<List<DropdownMenuItem>, int>(resultsDropdown, nbResults));
  }

  void showedMovieAtIndex(int index) {
    if (index < _results.length - 1) return;
    _loadNextPage();
  }
  void onMovieTap(BuildContext context, int index, List<SearchListRowData> options, String  mediaType) {
    final id = options[index].id;
    switch (mediaType) {
      case 'movie':
        Navigator.of(context).pushNamed(
          MainNavigationRoutesName.movieDetails,
          arguments: id
        );
      case 'tv':
        Navigator.of(context).pushNamed(
          MainNavigationRoutesName.tvShowScreenDetails,
          arguments: id,
        );
      case 'person':
        Navigator.of(context).pushNamed(
          MainNavigationRoutesName.personsScreenDetails,
          arguments: id,
        );
        break;
      default:
    }
  }
  void discoverPage(BuildContext context){
    Navigator.of(context).pushNamed(
      MainNavigationRoutesName.discoverScreen,
    );
  }

  SearchListRowData _makeRowData(Result movieTvPerson){
    final releaseDate = movieTvPerson.releaseDate;
    final releaseDateTitle = releaseDate != null ? _dateFormat.format(releaseDate) : '';
    final voteAverage = movieTvPerson.voteAverage?.toStringAsPrecision(2) ?? '';
    final voteCount = movieTvPerson.voteCount.toString();
    final overview = movieTvPerson.overview ?? '';
    final name = movieTvPerson.name;
    final mediaType = movieTvPerson.mediaType.name;
    final popularity = movieTvPerson.popularity;
    final firstAirDate = movieTvPerson.firstAirDate;
    final firstAirDateTitle = firstAirDate != null ? _dateFormat.format(firstAirDate) : '';
    final birthday = movieTvPerson.firstAirDate;
    final birthdayTitle = birthday != null ? _dateFormat.format(birthday) : '';
    final profilePath = movieTvPerson.profilePath;
    final originalName = movieTvPerson.originalName;
    return SearchListRowData(
      id: movieTvPerson.id,
      posterPath: movieTvPerson.posterPath,
      title: movieTvPerson.title,
      releaseDate: releaseDateTitle,
      overview: overview,
      voteAverage: voteAverage,
      voteCount: voteCount,
      name: name,
      mediaType: mediaType,
      popularity: popularity,
      firstAirDate: firstAirDateTitle,
      birthday: birthdayTitle,
      profilePath: profilePath,
      originalName: originalName
    );
  }
}


