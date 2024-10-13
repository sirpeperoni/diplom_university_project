import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/entity/movie.dart';
import 'package:the_movie_db/domain/services/movie_service.dart';
import 'package:the_movie_db/library/Widgets/localized_model.dart';
import 'package:the_movie_db/library/paginator.dart';


class MovieListRowData {
  final int id;
  final String? posterPath;
  final String title;
  final String releaseDate;
  final String overview;

  MovieListRowData(
    {required this.id,
     required this.posterPath,
     required this.title,
     required this.releaseDate,
     required this.overview
  });
}


class ResultsModel extends ChangeNotifier{
  final _movieService = MovieService();
  late final Paginator<Movie> _discoverMoviePaginator;
  final _localStorage = LocalizedModelStorage();
  var _movies = <MovieListRowData>[];
  late DateFormat _dateFormat;
  bool isLoading = true;

  List<MovieListRowData> get movies => List.unmodifiable(_movies);

  ResultsModel(String genres, String countries){
    _discoverMoviePaginator = Paginator<Movie>((page) async {
      final result = await _movieService.getDiscoverMovies(page, _localStorage.localeTag, genres, countries);
      return PaginatorLoadResult(data: result.movies, currentPage: result.page, totalPage: result.totalPages);
    } );
  }

  Future<void> setupLocale(Locale locale) async {
    if(!_localStorage.updateLocale(locale)) return;
    _dateFormat = DateFormat.yMMMMd(_localStorage.localeTag);
    await resetList();
  }

  Future<void> resetList() async {
    await _discoverMoviePaginator.reset();
    _movies.clear();
    await _loadNextPage();
  }



  Future<void> _loadNextPage() async {
    await _discoverMoviePaginator.loadNextPage();
    _movies = _discoverMoviePaginator.data.map(_makeRowData).toList();
    isLoading = false;
    notifyListeners();
  }

  MovieListRowData _makeRowData(Movie movie){
    final releaseDate = movie.releaseDate;
    final releaseDateTitle = releaseDate != null ? _dateFormat.format(releaseDate) : '';
    return MovieListRowData(id: movie.id, posterPath: movie.posterPath, title: movie.title, releaseDate: releaseDateTitle, overview: movie.overview);
  }

  void showedMovieAtIndex(int index) {
    if (index < _movies.length - 1) return;
    _loadNextPage();
  }
}