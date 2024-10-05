import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/entity/popular_movie_response.dart';
import 'package:the_movie_db/domain/entity/popular_tv_show_response.dart';
import 'package:the_movie_db/domain/entity/rated_movies.dart';
import 'package:the_movie_db/domain/entity/rated_tv_response.dart';


enum MediaType{
  movie,
  tv
}

extension MediaTypeAsString on MediaType{
  String asString(){
    switch(this){
      case MediaType.movie: return 'movie';
      case MediaType.tv: return 'tv';
    }
  }
}


class AccountApiClient{
  final _networkClient = NetworkClient();

  Future<int> getAccountInfo(String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final result = jsonMap['id'] as int;
      return result;
    }
    final result = _networkClient.get(
      '/account',parser,  
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id': sessionId,
      }
    );
    return result;
  }

  // Написать типы для кажлого запроса 
  Future<RatedMoviesResponse> getRatedMovies({required int accountId, required int page,required String locale, required String sessionId, required String sortBy}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = RatedMoviesResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/account/$accountId/rated/movies',parser,  
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'page':page.toString(),
        'language':locale,
        'session_id':sessionId,
        'sort_by':sortBy
      }
    );
    return result;
  }

  Future<PopularMovieResponse> getFavoriteMovies({required int accountId, required int page,required String locale, required String sessionId, required String sortBy}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/account/$accountId/favorite/movies',parser,  
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'page':page.toString(),
        'language':locale,
        'session_id':sessionId,
        'sort_by':sortBy
      }
    );
    return result;
  }

  Future<PopularTvShowResponse> getFavoriteTvShows({required int accountId, required int page,required String locale, required String sessionId, required String sortBy}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularTvShowResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/account/$accountId/favorite/tv',parser,  
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'page':page.toString(),
        'language':locale,
        'session_id':sessionId,
        'sort_by':sortBy
      }
    );
    return result;
  }

  Future<RatedTvResponse> getRatedTv({required int accountId, required int page,required String locale, required String sessionId, required String sortBy}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = RatedTvResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/account/$accountId/rated/tv',parser,  
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'page':page.toString(),
        'language':locale,
        'session_id':sessionId,
        'sort_by':sortBy
      }
    );
    return result;
  }

  Future<PopularMovieResponse> getWatchlistMovies({required int accountId, required int page,required String locale, required String sessionId, required String sortBy}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/account/$accountId/watchlist/movies',parser,  
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'page':page.toString(),
        'language':locale,
        'session_id':sessionId,
        'sort_by':sortBy
      }
    );
    return result;
  }

  Future<PopularTvShowResponse> getWatchlistTvShows({required int accountId, required int page,required String locale, required String sessionId, required String sortBy}) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularTvShowResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/account/$accountId/watchlist/tv',parser,  
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'page':page.toString(),
        'language':locale,
        'session_id':sessionId,
        'sort_by':sortBy
      }
    );
    return result;
  }

  Future<String> markAsFavorite({
    required int accountId, 
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isFavorite,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }
    final parameters = <String, dynamic>{
        'media_type': mediaType.asString(),
        'media_id': mediaId,
        'favorite': isFavorite,
      };
    final result = _networkClient.post('/account/$accountId/favorite', parameters, parser, <String, dynamic>{'api_key': Configuration.apiKey, 'session_id': sessionId});
    return result;  
  }

  Future<String> markAsWatchlist({
    required int accountId, 
    required String sessionId,
    required MediaType mediaType,
    required int mediaId,
    required bool isWatchlist,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }
    final parameters = <String, dynamic>{
        'media_type': mediaType.asString(),
        'media_id': mediaId,
        'watchlist': isWatchlist,
      };
    final result = _networkClient.post('/account/$accountId/watchlist', parameters, parser, <String, dynamic>{'api_key': Configuration.apiKey, 'session_id': sessionId});
    return result;  
  }


}