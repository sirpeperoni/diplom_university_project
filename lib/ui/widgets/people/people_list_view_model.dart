import 'dart:async';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:the_movie_db/domain/entity/popular_people_response.dart';
import 'package:the_movie_db/domain/services/people_service.dart';
import 'package:the_movie_db/library/Widgets/localized_model.dart';
import 'package:the_movie_db/library/paginator.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';

class PeopleListRowData {
  final int id;
  final String profilePath;
  final String name;
  final double popularity;
  final String knownForDepartment;

  PeopleListRowData(
    {required this.id,
     required this.profilePath,
     required this.name,
     required this.popularity,
     required this.knownForDepartment
  });
}

class PeopleListViewModel extends ChangeNotifier{
  final _peopleService = PeopleService();
  final _localStorage =   LocalizedModelStorage();
  late final Paginator<ActorInList> _popularPeoplePaginator;
  late final Paginator<ActorInList> _searchPeoplePaginator;
  Timer? searchDeboubce;

  var _people = <PeopleListRowData>[];
  String? _searchQuery;
  bool get isSearchMode{
    final searchQuery = _searchQuery;
    return searchQuery != null && searchQuery.isNotEmpty;
  }


  List<PeopleListRowData> get people => List.unmodifiable(_people);
  late DateFormat _dateFormat;

  PeopleListViewModel(){
    _popularPeoplePaginator = Paginator<ActorInList>((page) async {
      final result = await _peopleService.popularPeople(page, _localStorage.localeTag);
      return PaginatorLoadResult(data: result.people, currentPage: result.page, totalPage: result.totalPages);
    });
    _searchPeoplePaginator = Paginator<ActorInList>((page) async {
      final result = await _peopleService.searchPeople(page, _localStorage.localeTag, _searchQuery ?? '');
      return PaginatorLoadResult(data: result.people, currentPage: result.page, totalPage: result.totalPages);
    });
  }

  Future<void> setupLocale(Locale locale) async {
    if(!_localStorage.updateLocale(locale)) return;
    _dateFormat = DateFormat.yMMMMd(_localStorage.localeTag);
    await _resetList();
  }

  Future<void> _resetList() async {
    await _popularPeoplePaginator.reset();
    await _searchPeoplePaginator.reset();
    _people.clear();
    await _loadNextPage();
  }

  Future<void> _loadNextPage() async {
    if(isSearchMode){
      await _searchPeoplePaginator.loadNextPage();
      _people = _searchPeoplePaginator.data.map(_makeRowData).toList();    
    } else{
      await _popularPeoplePaginator.loadNextPage();
      _people = _popularPeoplePaginator.data.map(_makeRowData).toList();
    }
    notifyListeners();
  }

  PeopleListRowData _makeRowData(ActorInList actor){
    final profilePath = actor.profilePath ?? '';
    return PeopleListRowData(
      id: actor.id, 
      profilePath: profilePath, 
      name: actor.name,
      popularity: actor.popularity,
      knownForDepartment: actor.knownForDepartment
    );
  }

  Future<void> searchPeople(String text) async {
    searchDeboubce?.cancel();
    searchDeboubce = Timer(const Duration(milliseconds: 300), () async {
      final searchQuery = text.isNotEmpty ? text : null;
      if (_searchQuery == searchQuery) return;
      _searchQuery = searchQuery;
    });
    _people.clear();
    if(isSearchMode){
      await _searchPeoplePaginator.reset();
    }
    _loadNextPage();
  }

  void onPersonTap(BuildContext context, int index) {
    final id = _people[index].id;
    Navigator.of(context).pushNamed(
      MainNavigationRoutesName.personsScreenDetails,
      arguments: id,
    );
  }



  void showedPeopleAtIndex(int index) {
    if (index < _people.length - 1) return;
    _loadNextPage();
  }
}