import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/factory/screen_factory.dart';
import 'package:the_movie_db/ui/widgets/discover/discover_model.dart';


abstract class MainNavigationRoutesName{
  static const loaderWidget = '/';
  static const auth = '/auth';
  static const mainScreen = '/main_screen';
  static const tvShowScreen = '/tv_show_screen';
  static const personsScreen = '/persons_screen';
  static const movieDetails = '/main_screen/movie_details';
  static const movieTrailerWidget = '/main_screen/movie_details/trailer';
  static const personsScreenDetails = '/persons_screen/person_details';
  static const tvShowScreenDetails = '/tv_show_screen/tv_show_details';
  static const discoverScreen = '/discover';
  static const discoverScreenMovieResult = '/discover/movies';
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
    MainNavigationRoutesName.personsScreen: (_) => _screenFactory.makePeopleList(),
    MainNavigationRoutesName.discoverScreen: (_) => _screenFactory.makeDiscoverWidget()
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
      case MainNavigationRoutesName.discoverScreenMovieResult:
        final arguments = settings.arguments;
        final args = arguments is ScreenArguments ? arguments : ScreenArguments(countries: '', genres: '', primaryReleaseDateGTE: '', primaryReleaseDateLTE: '', voteAverageGte: 0, voteAverageLte: 10, sortBy: 'vote_average.desc');
        final genres = args.genres;
        final countries = args.countries;
        final primaryReleaseDateGTE = args.primaryReleaseDateGTE;
        final primaryReleaseDateLTE = args.primaryReleaseDateLTE;
        final voteAverageGte = args.voteAverageGte;
        final voteAverageLte = args.voteAverageLte;
        final sortBy = args.sortBy;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeDiscoverMoviesListWidget(genres, countries, primaryReleaseDateGTE, primaryReleaseDateLTE, voteAverageGte, voteAverageLte, sortBy),
        );
      case MainNavigationRoutesName.tvShowScreenDetails:
        final arguments = settings.arguments;
        final personId = arguments is int ? arguments : 0;
        return MaterialPageRoute(
          builder: (_) => _screenFactory.makeTvShowDetails(personId)
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

