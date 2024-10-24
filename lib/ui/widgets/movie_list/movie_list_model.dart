import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/entity/movie.dart';
import 'package:the_movie_db/domain/services/movie_service.dart';
import 'package:the_movie_db/library/Widgets/localized_model.dart';
import 'package:the_movie_db/library/paginator.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class MovieListRowData {
  final int id;
  final String? posterPath;
  final String title;
  final String releaseDate;
  final String overview;
  final String voteAverage;
  final String voteCount;

  MovieListRowData(
    {required this.id,
     required this.posterPath,
     required this.title,
     required this.releaseDate,
     required this.overview,
     required this.voteCount,
     required this.voteAverage
  });
}


class MovieListViewModel extends ChangeNotifier {
  final _movieService = MovieService();
  final _localStorage = LocalizedModelStorage();
  late final Paginator<Movie> _popularMoviePaginator;
  late final Paginator<Movie> _searchMoviePaginator;
  Timer? searchDeboubce;

  var _movies = <MovieListRowData>[];
  String? _searchQuery;
  bool get isSearchMode{
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }


  List<MovieListRowData> get movies => List.unmodifiable(_movies);
  late DateFormat _dateFormat;

  MovieListViewModel(){
    _popularMoviePaginator = Paginator<Movie>((page) async {
      final result = await _movieService.popularMovie(page, _localStorage.localeTag);
      return PaginatorLoadResult(data: result.movies, currentPage: result.page, totalPage: result.totalPages);
    });
    _searchMoviePaginator = Paginator<Movie>((page) async {
      final result = await _movieService.searchMovie(page, _localStorage.localeTag, _searchQuery ?? '');
      return PaginatorLoadResult(data: result.movies, currentPage: result.page, totalPage: result.totalPages);
    });
  }

  Future<void> setupLocale(Locale locale) async {
    if(!_localStorage.updateLocale(locale)) return;
    _dateFormat = DateFormat.yMMMMd(_localStorage.localeTag);
    await resetList();
  }

  Future<void> resetList() async {
    await _popularMoviePaginator.reset();
    await _searchMoviePaginator.reset();
    _movies.clear();
    await _loadNextPage();
  }



  Future<void> _loadNextPage() async {
    if(isSearchMode){
      await _searchMoviePaginator.loadNextPage();
      _movies = _searchMoviePaginator.data.map(_makeRowData).toList();    
    } else{
      await _popularMoviePaginator.loadNextPage();
      _movies = _popularMoviePaginator.data.map(_makeRowData).toList();
    }
    notifyListeners();
  }

  MovieListRowData _makeRowData(Movie movie){
    final releaseDate = movie.releaseDate;
    final releaseDateTitle = releaseDate != null ? _dateFormat.format(releaseDate) : '';
    final voteAverage = movie.voteAverage.toStringAsPrecision(2);
    final voteCount = movie.voteCount.toString();
    return MovieListRowData(
      id: movie.id,
      posterPath: movie.posterPath,
      title: movie.title,
      releaseDate: releaseDateTitle,
      overview: movie.overview,
      voteAverage: voteAverage,
      voteCount: voteCount
    );
  }

  void onMovieTap(BuildContext context, int index) {
    final id = _movies[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRoutesName.movieDetails,
      arguments: id
    );
  }

  Future<void> serachMovie(String text) async {
    searchDeboubce?.cancel();
    searchDeboubce = Timer(const Duration(milliseconds: 300), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
    });
    _movies.clear();
    if(isSearchMode){
      await _searchMoviePaginator.reset();
    }
    _loadNextPage();
  }

  void showedMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }
}