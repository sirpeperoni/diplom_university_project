import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/entity/search.dart';


class SearchApiClient{
  final _networkClient = NetworkClient();

  Future<Search> search(int page, String locale, String query, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = Search.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/search/multi',parser,  
      <String, dynamic>{
        'api_key': apiKey,
        'page':page.toString(),
        'language':locale,
        'query': query,
        'include_adult': false.toString(),
      }
    );
    return result;
  }
}