import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/entity/popular_people_response.dart';

class PeopleApiClient{
  final _networkClient = NetworkClient();

  Future<PopularPeopleResponse> popularPeople(int page, String locale, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      print(jsonMap);
      final response = PopularPeopleResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get('/person/popular',parser,  <String, dynamic>{'api_key': apiKey,'page':page.toString(), 'language':locale});
    return result;
  }

  Future<PopularPeopleResponse> searchPeople(int page, String locale, String query, String apiKey) async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = PopularPeopleResponse.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get(
      '/search/person',parser,  
      <String, dynamic>{
        'api_key': apiKey,
        'page':page.toString(),
        'language':locale,
        'query': query,
        'include_adult': true.toString()
      }
    );
    return result;
  }
}