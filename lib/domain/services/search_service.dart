import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/api_client/search_api_client.dart';
import 'package:the_movie_db/domain/entity/search.dart';

class SearchService {
  final _searchApiClient = SearchApiClient();

  Future<Search> search(int page, String locale, String query) async =>
    _searchApiClient.search(page, locale, query, Configuration.apiKey);

  
}