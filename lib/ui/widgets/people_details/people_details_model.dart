import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/api_client/api_client_exception.dart';
import 'package:the_movie_db/domain/entity/people_details.dart';
import 'package:the_movie_db/domain/services/auth_service.dart';
import 'package:the_movie_db/domain/services/people_service.dart';
import 'package:the_movie_db/library/Widgets/localized_model.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';



class PeopleDetailsData{
  String name = "";
  bool isLoading = true;
  String biography = "";
  String? profilePath;
  String knownForDepartment = "";
  int gender = 0;
  String birthday = "";
  String? deathhday;
  String? placeOfBirth;
  List<String>? alsoKnownAs;
}

class PeopleDetailsViewModel extends ChangeNotifier{
  final _peopleService = PeopleService();
  final data = PeopleDetailsData();
  final _localeStorage = LocalizedModelStorage();
  final _authService = AuthService(); 
  final int peopleId;

  PeopleDetailsViewModel(this.peopleId);

  Future<void> setupLocale(BuildContext context, Locale locale) async {
    if(!_localeStorage.updateLocale(locale)) return;
    updateData(null);
    await loadDetails(context);
  }

  void updateData(PeopleDetails? details){
    data.name = details?.name ?? "Загрузка...";
    data.isLoading = details == null;
    if(details == null){
      notifyListeners();
      return;
    }
    data.biography = details.biography ?? "";
    data.profilePath = details.profilePath;
    data.knownForDepartment = details.knownForDepartment;
    data.gender = details.gender;
    data.birthday = details.birthday.toString();
    data.deathhday = details.deathhday.toString();
    data.placeOfBirth = details.placeOfBirth;
    data.alsoKnownAs = details.alsoKnownAs;  
    notifyListeners();
  }

  Future<void> loadDetails(BuildContext context) async {
    try{
      final details = await _peopleService.loadDetails(locale: _localeStorage.localeTag, peopleId: peopleId);
      updateData(details);
    } on ApiClientException catch(e) {
      // ignore: use_build_context_synchronously
      _handleApiClientException(e, context);
    }
  }



  void _handleApiClientException(ApiClientException exeption, BuildContext context){
      switch (exeption.type) {
        case ApiClientExceptionType.sessionExpired:
          _authService.logout();
          MainNavigation.resetNavigation(context);
          break;
        default:
          // ignore: avoid_print
          print(exeption);
      }
  }

}