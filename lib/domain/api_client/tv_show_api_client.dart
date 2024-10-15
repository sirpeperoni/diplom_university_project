import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/entity/popular_tv_show_response.dart';
import 'package:the_movie_db/domain/entity/tv_show_details.dart';


class TvShowApiClient{
  final _networkClient = NetworkClient();

  Future<PopularTvShowResponse> popularTvShows(int page, String locale, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularTvShowResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get('/tv/popular',parser,  <String, dynamic>{'api_key': apiKey,'page':page.toString(), 'language':locale});
    return result;
  }

  Future<PopularTvShowResponse> searchTvShow(int page, String locale, String query, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularTvShowResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/search/tv',parser,  
      <String, dynamic>{
        'api_key': apiKey,
        'page':page.toString(),
        'language':locale,
        'query': query,
        'include_adult': false.toString()
      }
    );
    return result;
  }

  

  Future<TvShowDetails> tvShowDetails(int seriesId, String locale) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = TvShowDetails.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/tv/$seriesId',parser,  
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'language':locale,
        'append_to_response': 'credits,videos',
      }
    );
    return result;
  }
}