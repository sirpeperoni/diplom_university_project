import 'package:the_movie_db/configuration/configuration.dart';
import 'package:the_movie_db/domain/api_client/people_api_client.dart';
import 'package:the_movie_db/domain/entity/popular_people_response.dart';

class PeopleService{
  final _peopleApiClient = PeopleApiClient();

  Future<PopularPeopleResponse> popularPeople(int page, String locale) async => 
    _peopleApiClient.popularPeople(page, locale, Configuration.apiKey);
    
  Future<PopularPeopleResponse> searchPeople(int page, String locale, String query) async =>
    _peopleApiClient.searchPeople(page, locale, query, Configuration.apiKey);
}