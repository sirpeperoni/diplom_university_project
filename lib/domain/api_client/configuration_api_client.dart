import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/api_client/network_client.dart';
import 'package:the_movie_db/domain/entity/discover/countries.dart';
import 'package:the_movie_db/domain/entity/discover/details.dart';

class ConfigurationApiClient{
  final _networkClient = NetworkClient();

  Future<Details> getDetails() async {
    parser(dynamic json) {
      final jsonMap = json as Map<String, dynamic>;
      final response = Details.fromJson(jsonMap);
      return response;
    }
    final result = _networkClient.get('/configuration', parser, <String, dynamic>{'api_key': Configuration.apiKey});
    return result;
  }

  Future<List<dynamic>> getCountries(String language) async {
    parser(dynamic json) {
      final jsonMap = json as List<dynamic>;
      return jsonMap;
    }
    final result = _networkClient.get('/configuration/countries', parser, <String, dynamic>{'api_key': Configuration.apiKey, 'language': language});
    return result;
  }
}