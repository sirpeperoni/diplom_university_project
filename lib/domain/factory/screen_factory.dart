import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_model.dart';
import 'package:the_movie_db/ui/widgets/auth/auth_widget.dart';
import 'package:the_movie_db/ui/widgets/loader_widget/loader_view_model.dart';
import 'package:the_movie_db/ui/widgets/loader_widget/loader_widget.dart';
import 'package:the_movie_db/ui/widgets/main_screen/main_screen_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_list/movie_list_model.dart';
import 'package:the_movie_db/ui/widgets/movie_list/movie_list_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_trailer/movie_trailer_widget.dart';
import 'package:the_movie_db/ui/widgets/news/new_widget.dart';
import 'package:the_movie_db/ui/widgets/people/people_list.dart';
import 'package:the_movie_db/ui/widgets/people/people_list_view_model.dart';
import 'package:the_movie_db/ui/widgets/people_details/people_details_model.dart';
import 'package:the_movie_db/ui/widgets/people_details/people_details_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_show_details/tv_show_details_model.dart';
import 'package:the_movie_db/ui/widgets/tv_show_details/tv_show_details_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_show_list_widget.dart/tv_show_list_model.dart';
import 'package:the_movie_db/ui/widgets/tv_show_list_widget.dart/tv_show_list_widget.dart';

class ScreenFactory{
  Widget makeLoader() {
    return Provider(
      create: (context) => LoaderViewModel(context),
      lazy: false,
      child: const LoaderWidget(),
    );
  }

  Widget makeMainScreenWidget(){
    return const MainScreenWidget();
  }

  Widget makeAuthWidget(){
    return ChangeNotifierProvider(
      create: (_) => AuthModel(),
      child: const AuthWidget()
    );
  }

  Widget makeMovieDetails(int movieId){
    return ChangeNotifierProvider(
      create:(_) => MovieDetailsModel(movieId),
      child: const MovieDetailsWidget(),
    );
  }

  Widget makeTvShowDetails(int seriesId){
    return ChangeNotifierProvider(
            create:(_) => TvShowDetailsModel(seriesId),
            child: const TvShowDetailsWidget(),
          );
  }

  Widget makeMovieTrailer(String youtubeKey){
    return MovieTrailerWidget(youtubeKey: youtubeKey);
  }

  Widget makeNewsList(){
    return const NewsWidget();
  }

  Widget makeMovieList(){
    return MultiProvider(
      providers:[ 
        ChangeNotifierProvider(create: (_) => MovieListViewModel(),),
        ChangeNotifierProvider(create: (_) => TvShowViewModel(),)
      ],
      child: const MovieListWidget()
    );
  }

  Widget makeTvShowList(){
    return ChangeNotifierProvider(
      create: (_) => TvShowViewModel(),
      child: const TWShowListWidget()
    );
  }

  Widget makePersonDetails(int peopleId){
    return ChangeNotifierProvider(
            create:(_) => PeopleDetailsViewModel(peopleId),
            child: const PeopleDetailsWidget(),
          );
  }



  Widget makePeopleList(){
    return ChangeNotifierProvider(
      create: (_) => PeopleListViewModel(),
      child: const PeopleListWidget()
    );
  }
}