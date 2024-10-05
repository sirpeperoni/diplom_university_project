import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/entity/genres.dart';
import 'package:the_movie_db/domain/entity/movie_details.dart';
import 'package:the_movie_db/domain/entity/now_playing_movies.dart';
import 'package:the_movie_db/domain/entity/popular_movie_response.dart';







class MovieApiClient{
  final _networkClient = NetworkClient();

  Future<PopularMovieResponse> popularMovie(int page, String locale, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get('/movie/popular',parser,  <String, dynamic>{'api_key': apiKey,'page':page.toString(), 'language':locale});
    return result;
  }

  Future<NowPlayingMovies> noewPlayingMovie(int page, String locale, String apiKey, String region) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = NowPlayingMovies.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get('/movie/now_playing',parser,  <String, dynamic>{'api_key': apiKey,'page':page.toString(), 'language':locale, 'region':region});
    return result;
  }

  Future<PopularMovieResponse> searchMovie(int page, String locale, String query, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularMovieResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/search/movie',parser,  
      <String, dynamic>{
        'api_key': apiKey,
        'page':page.toString(),
        'language':locale,
        'query': query,
        'include_adult': true.toString(),
      }
    );
    return result;
  }

  Future<MovieDetails> movieDetails(int movieId, String locale, String? sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = MovieDetails.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/movie/$movieId',parser,  
      <String, dynamic>{
        'append_to_response': 'credits,videos,account_states',
        'api_key': Configuration.apiKey,
        'language':locale,
        'session_id':sessionId,
      }
    );
    return result;
  }

  Future<bool> isFavorite(int movieId, String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>; 
      final result = jsonMap['favorite'] as bool;
      return result;
    }
    final result = _networkClient.get(
      '/movie/$movieId/account_states',parser,  
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id':sessionId,
      }
    );
    return result;
  }

  Future<bool> isWatchlist(int movieId, String sessionId) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>; 
      final result = jsonMap['watchlist'] as bool;
      return result;
    }
    final result = _networkClient.get(
      '/movie/$movieId/account_states',parser,  
      <String, dynamic>{
        'api_key': Configuration.apiKey,
        'session_id':sessionId,
      }
    );
    return result;
  }

  Future<String> addRating({
    required int movieId, 
    required String sessionId,
    required double rate,
  }) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final token = jsonMap['request_token'] as String;
      return token;
    }
    final parameters = <String, dynamic>{
        'value': rate.toString(),
      };
    final result = _networkClient.post('/movie/$movieId/rating', parameters, parser, <String, dynamic>{'api_key': Configuration.apiKey, 'session_id': sessionId});
    return result;  
  }


  Future<void> deleteRaiting({required int movieId, required String sessionId}) async {
      _networkClient.delete('/movie/$movieId/rating', <String, dynamic>{'api_key': Configuration.apiKey,'session_id': sessionId});
  }

  Future<Genres> getMovieGenres() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = Genres.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get('/genre/movie/list', parser, <String, dynamic>{'api_key': Configuration.apiKey});
    return result;
  }




}

