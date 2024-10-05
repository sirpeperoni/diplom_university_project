import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/api_client/account_api_client.dart';
import 'package:the_movie_db/domain/api_client/tv_show_api_client.dart';
import 'package:the_movie_db/domain/entity/popular_tv_show_response.dart';
import 'package:the_movie_db/domain/entity/rated_tv_response.dart';
import 'package:the_movie_db/domain/entity/tv_show_details.dart';

class TvShowService{
  final _tvShowApiClient = TvShowApiClient();
  final _accountApiClient = AccountApiClient();

  Future<PopularTvShowResponse> popularTvShows(int page, String locale) async => 
    _tvShowApiClient.popularTvShows(page, locale, Configuration.apiKey);
    
  Future<PopularTvShowResponse> searchTvShows(int page, String locale, String query) async =>
    _tvShowApiClient.searchTvShow(page, locale, query, Configuration.apiKey);

  Future<TvShowDetails> loadDetails({required int seriesId, required String locale}) async => 
    _tvShowApiClient.tvShowDetails(seriesId, locale);

  Future<PopularTvShowResponse> favoriteTvShows(
    int page, 
    String locale, 
    int accountId, 
    String sessionId,
    String sortBy
  ) async => 
    _accountApiClient.getFavoriteTvShows(accountId: accountId, page: page, locale: locale, sessionId: sessionId, sortBy: sortBy);

  Future<RatedTvResponse> ratedTvShows(
    int page, 
    String locale, 
    int accountId, 
    String sessionId,
    String sortBy
  ) async => 
    _accountApiClient.getRatedTv(accountId: accountId, page: page, locale: locale, sessionId: sessionId, sortBy: sortBy);

  Future<PopularTvShowResponse> watchlistMovies(
    int page, 
    String locale, 
    int accountId, 
    String sessionId,
    String sortBy
  ) async => 
    _accountApiClient.getWatchlistTvShows(accountId: accountId, page: page, locale: locale, sessionId: sessionId, sortBy: sortBy);

}