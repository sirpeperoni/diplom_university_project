import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/api_client/tv_show_api_client.dart';
import 'package:the_movie_db/domain/entity/popular_tv_show_response.dart';
import 'package:the_movie_db/domain/entity/tv_show_details.dart';

class TvShowService{
  final _tvShowApiClient = TvShowApiClient();
  Future<PopularTvShowResponse> popularTvShows(int page, String locale) async => 
    _tvShowApiClient.popularTvShows(page, locale, Configuration.apiKey);
    
  Future<PopularTvShowResponse> searchTvShows(int page, String locale, String query) async =>
    _tvShowApiClient.searchTvShow(page, locale, query, Configuration.apiKey);

  Future<TvShowDetails> loadDetails({required int seriesId, required String locale}) async => 
    _tvShowApiClient.tvShowDetails(seriesId, locale);


}