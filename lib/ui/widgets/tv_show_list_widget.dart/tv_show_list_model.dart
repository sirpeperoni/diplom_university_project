import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/entity/tv_show.dart';
import 'package:the_movie_db/domain/services/tv_show_service.dart';
import 'package:the_movie_db/library/Widgets/localized_model.dart';
import 'package:the_movie_db/library/paginator.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class TvShowListRowData {
  final int id;
  final String? posterPath;
  final String title;
  final String firstAirDate;
  final String overview;
  final String voteAverage;
  final String voteCount;

  TvShowListRowData(
    {required this.id,
     required this.posterPath,
     required this.title,
     required this.firstAirDate,
     required this.overview,
     required this.voteCount,
     required this.voteAverage
  });
}

class TvShowViewModel extends ChangeNotifier{
  final _tvShowService = TvShowService();
  final _localStorage = LocalizedModelStorage();
  late final Paginator<TvShow> _popularTvShowPaginator;
  late final Paginator<TvShow> _searchTvShowPaginator;
  Timer? searchDeboubce;

  var _shows = <TvShowListRowData>[];
  String? _searchQuery;
  bool get isSearchMode{
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }

  List<TvShowListRowData> get shows => List.unmodifiable(_shows);
  late DateFormat _dateFormat;

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
    await resetList();
  }

  Future<void> resetList() async {
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
    final voteAverage = movie.voteAverage.toStringAsPrecision(2);
    final voteCount = movie.voteCount.toString();
    return TvShowListRowData(
      id: movie.id,
      posterPath: movie.posterPath,
      title: movie.name,
      firstAirDate: releaseDateTitle,
      overview: movie.overview,
      voteAverage: voteAverage,
      voteCount: voteCount
    );
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _shows[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRoutesName.tvShowScreenDetails,
      arguments: id,
    );
  }

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