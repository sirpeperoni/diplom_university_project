import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/entity/tv_show.dart';
import 'package:the_movie_db/domain/services/tv_show_service.dart';
import 'package:the_movie_db/library/Widgets/localized_model.dart';
import 'package:the_movie_db/library/paginator.dart';

class TvShowListRowData {
  final int id;
  final String? posterPath;
  final String title;
  final String firstAirDate;
  final String overview;

  TvShowListRowData(
    {required this.id,
     required this.posterPath,
     required this.title,
     required this.firstAirDate,
     required this.overview
  });
}

class TvShowViewModel extends ChangeNotifier{
  final _tvShowService = TvShowService();
  final _localStorage = LocalizedModelStorage();
  late final Paginator<TvShow> _popularTvShowPaginator;
  late final Paginator<TvShow> _searchTvShowPaginator;
  var _shows = <TvShowListRowData>[];
  String? _searchQuery;
  List<TvShowListRowData> get shows => List.unmodifiable(_shows);
  late DateFormat _dateFormat;
  Timer? searchDeboubce;
  
  bool get isSearchMode{
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }

  TvShowViewModel(){
    _popularTvShowPaginator = Paginator<TvShow>((page) async {
      final result = await _tvShowService.popularTvShows(page, _localStorage.localeTag);
      return PaginatorLoadResult(data: result.shows, currentPage: result.page, totalPage: result.totalPages);
    });
    _searchTvShowPaginator = Paginator<TvShow>((page) async {
      final result = await _tvShowService.searchTvShows(page, _localStorage.localeTag, _searchQuery ?? '');
      return PaginatorLoadResult(data: result.shows, currentPage: result.page, totalPage: result.totalPages);
    });
  }

  Future<void> setupLocale(Locale locale) async {
    if(!_localStorage.updateLocale(locale)) return;
    _dateFormat = DateFormat.yMMMMd(_localStorage.localeTag);
    await _resetList();
  }

  Future<void> _resetList() async {
    await _popularTvShowPaginator.reset();
    await _searchTvShowPaginator.reset();
    _shows.clear();
    await _loadNextPage();
  }

  Future<void> _loadNextPage() async {
    if(isSearchMode){
      await _searchTvShowPaginator.loadNextPage();
      _shows = _searchTvShowPaginator.data.map(_makeRowData).toList();    
    } else{
      await _popularTvShowPaginator.loadNextPage();
      _shows = _popularTvShowPaginator.data.map(_makeRowData).toList();
    }
    notifyListeners();
  }

  TvShowListRowData _makeRowData(TvShow movie){
    final releaseDate = movie.firstAirDate;
    final releaseDateTitle = releaseDate != null ? _dateFormat.format(releaseDate) : '';
    return TvShowListRowData(id: movie.id, posterPath: movie.posterPath, title: movie.name, firstAirDate: releaseDateTitle, overview: movie.overview);
  }

  // void onMovieTap(BuildContext context, int index) {
  //   final id = _movies[index].id;
  //   Navigator.of(context).pushNamed(
  //     MainNavigationRoutesName.movieDetails,
  //     arguments: id,
  //   );
  // }

  Future<void> serachTvShow(String text) async {
    searchDeboubce?.cancel();
    searchDeboubce = Timer(const Duration(milliseconds: 300), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
    });
    _shows.clear();
    if(isSearchMode){
      await _searchTvShowPaginator.reset();
    }
    _loadNextPage();
  }

  void showedTvShowAtIndex(int index) {
    if (index < _shows.length - 1) return;
    _loadNextPage();
  }
}