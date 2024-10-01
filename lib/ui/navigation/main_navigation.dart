import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/factory/screen_factory.dart';


abstract class MainNavigationRoutesName{
  static const loaderWidget = '/';
  static const auth = '/auth';
  static const mainScreen = '/main_screen';
  static const tvShowScreen = '/tv_show_screen';
  static const personsScreen = '/persons_screen';
  static const movieDetails = '/main_screen/movie_details';
  static const movieTrailerWidget = '/main_screen/movie_details/trailer';
  static const personsScreenDetails = '/persons_screen/person_details';
}


class MainNavigation{
  static final _screenFactory = ScreenFactory(); 
  String initialRoute(bool isAuth) => isAuth
      ? MainNavigationRoutesName.mainScreen 
      : MainNavigationRoutesName.auth;
  
  final routes = <String, Widget Function(BuildContext)>{
    MainNavigationRoutesName.loaderWidget: (_) => _screenFactory.makeLoader(),
    MainNavigationRoutesName.auth: (_) => _screenFactory.makeAuthWidget(),
    MainNavigationRoutesName.mainScreen: (_) => _screenFactory.makeMainScreenWidget(),
    MainNavigationRoutesName.tvShowScreen: (_) => _screenFactory.makeTvShowList(),
    MainNavigationRoutesName.personsScreen: (_) => _screenFactory.makePeopleList()
  };

  Route<Object> onGenerateRoute(RouteSettings settings){
    switch (settings.name){
      case MainNavigationRoutesName.movieDetails:
        final arguments = settings.arguments;
        final movieId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeMovieDetails(movieId)
        );
      case MainNavigationRoutesName.movieTrailerWidget:
        final arguments = settings.arguments;
        final youtubeKey = arguments is String ? arguments : '';
        return MaterialPageRoute(
          builder: (context) => _screenFactory.makeMovieTrailer(youtubeKey)
        );
      case MainNavigationRoutesName.personsScreenDetails:
        final arguments = settings.arguments;
        final personId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makePersonDetails(personId)
        );
      default:
        const widget = Text("Navigation error!!!");
        return MaterialPageRoute(builder: (context) => widget);
    }
  }

  static void resetNavigation(BuildContext context){
    Navigator.of(context).pushNamedAndRemoveUntil(MainNavigationRoutesName.loaderWidget, (route) => false);
  }
}

