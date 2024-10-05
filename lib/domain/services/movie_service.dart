import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/api_client/account_api_client.dart';
import 'package:the_movie_db/domain/api_client/movie_api_client.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/entity/genres.dart';
import 'package:the_movie_db/domain/entity/popular_movie_response.dart';
import 'package:the_movie_db/domain/entity/rated_movies.dart';
import 'package:the_movie_db/domain/local_entity/movie_details_local.dart';

class MovieService{
  final _movieApiClient = MovieApiClient();
  final _accountApiClient = AccountApiClient();
  final _sessionDataProvider = SessionDataProvider();

  Future<PopularMovieResponse> popularMovie(int page, String locale) async => 
    _movieApiClient.popularMovie(page, locale, Configuration.apiKey);
    
  Future<PopularMovieResponse> searchMovie(int page, String locale, String query) async =>
    _movieApiClient.searchMovie(page, locale, query, Configuration.apiKey);

  Future<PopularMovieResponse> favoriteMovies(
    int page, 
    String locale, 
    int accountId, 
    String sessionId,
    String sortBy
  ) async => 
    _accountApiClient.getFavoriteMovies(accountId: accountId, page: page, locale: locale, sessionId: sessionId, sortBy: sortBy);

  Future<RatedMoviesResponse> ratedMovies(
    int page, 
    String locale, 
    int accountId, 
    String sessionId,
    String sortBy
  ) async => 
    _accountApiClient.getRatedMovies(accountId: accountId, page: page, locale: locale, sessionId: sessionId, sortBy: sortBy);

  Future<PopularMovieResponse> watchlistMovies(
    int page, 
    String locale, 
    int accountId, 
    String sessionId,
    String sortBy
  ) async => 
    _accountApiClient.getWatchlistMovies(accountId: accountId, page: page, locale: locale, sessionId: sessionId, sortBy: sortBy);

  Future<Genres> getMovieGenres() async => _movieApiClient.getMovieGenres();

  Future<MovieDetailsLocal> loadDetails(
    {
      required int movieId,
      required String locale
    }
  ) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final movieDetails = await _movieApiClient.movieDetails(movieId, locale, sessionId);
    var isFavorite = false;
    var isWatchlist = false;
    if(sessionId != null){
      isFavorite = await _movieApiClient.isFavorite(movieId, sessionId);
      isWatchlist = await _movieApiClient.isWatchlist(movieId, sessionId);
    }
    return MovieDetailsLocal(details: movieDetails, isFavorite: isFavorite,isWatchlist:isWatchlist);
  }

  Future<void> updateFavorite({required int movieId,required bool isFavorite}) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if(sessionId == null || accountId == null) return;
    await _accountApiClient.markAsFavorite(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: MediaType.movie,
      mediaId: movieId,
      isFavorite: isFavorite,
    );
  }

  Future<void> updateWathclist({required int movieId,required bool isWatchlist}) async {
    final sessionId = await _sessionDataProvider.getSessionId();
    final accountId = await _sessionDataProvider.getAccountId();

    if(sessionId == null || accountId == null) return;
    await _accountApiClient.markAsWatchlist(
      accountId: accountId,
      sessionId: sessionId,
      mediaType: MediaType.movie,
      mediaId: movieId,
      isWatchlist: isWatchlist,
    );
  }

  Future<void> updateRating({required int movieId,required double rate}) async {
    final sessionId = await _sessionDataProvider.getSessionId();

    if(sessionId == null) return;
    await _movieApiClient.addRating(
      movieId: movieId,
      sessionId: sessionId,
      rate: rate
    );
  }

  Future<void> deleteRaiting({required int movieId}) async {
    final sessionId = await _sessionDataProvider.getSessionId();

    if(sessionId == null) return;
    await _movieApiClient.deleteRaiting(movieId: movieId, sessionId: sessionId);
  }
}