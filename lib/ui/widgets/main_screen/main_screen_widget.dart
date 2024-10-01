import 'package:flutter/material.dart';
import 'package:the_movie_db/domain/data_providers/session_data_provider.dart';
import 'package:the_movie_db/domain/factory/screen_factory.dart';

class MainScreenWidget extends StatefulWidget {
  const MainScreenWidget({super.key});

  @override
  State<MainScreenWidget> createState() => _MainScreenWidgetState();
}

class _MainScreenWidgetState extends State<MainScreenWidget> {

  int _selectedTab = 1;
  final _screenFactory = ScreenFactory();


  void onSelectTab(int index){
    if (_selectedTab == index) return;
    setState(() {
      _selectedTab = index;
    });
  }




  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TMDB", style: TextStyle(color: Colors.white,)),
        actions: [
          IconButton(onPressed: () => SessionDataProvider().setSessionId(null), icon: const Icon(Icons.search, color: Colors.white,))
        ],
      ),
      body: IndexedStack(
        index: _selectedTab,
        children: [
          _screenFactory.makeNewsList(),
          _screenFactory.makeMovieList(),
          _screenFactory.makeTvShowList(),
          _screenFactory.makePeopleList()
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedTab,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: "Новости"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_filter),
            label: "Фильмы"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.tv),
            label: "Сериалы"
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: "Люди"
          ), 
        ],
        onTap: onSelectTab,
      ),
    );
  }
}


