import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/cache/cached_images.dart';
import 'package:the_movie_db/ui/widgets/movie_list/movie_list_model.dart';


class MovieListWidget extends StatefulWidget {
  const MovieListWidget({super.key});

  @override
  State<MovieListWidget> createState() => _MovieListWidgetState();
}

class _MovieListWidgetState extends State<MovieListWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<MovieListViewModel>().setupLocale(locale);
  }
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _MovieListWidget(),
        //_SearchWidget()
      ],
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListViewModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: model.serachMovie,
        decoration: InputDecoration(
          labelText: 'Поиск',
          filled: true,
          fillColor: Colors.white.withAlpha(235),
          border: const OutlineInputBorder(),
        ),
      ),
    );
  }
}

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<MovieListViewModel>();
    return RefreshIndicator(
      onRefresh: () => model.resetList(),
      child: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: model.movies.length,
        itemExtent: 163,
        itemBuilder: (BuildContext context, int index) {
          model.showedMovieAtIndex(index);
          return _MovieListRowWidget(index: index);
        },
      ),
    );
  }
}


class _MovieListRowWidget extends StatelessWidget {
  final int index;
  const _MovieListRowWidget
  ({required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieListViewModel>();
    final movie = model.movies[index];
    final posterPath = movie.posterPath;
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.black.withOpacity(0.2)),
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1),
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          clipBehavior: Clip.hardEdge,
          child: Row(
            children: [
              if(posterPath != null)
                CacheImage(imagePath: posterPath, width: 95),             
              const SizedBox(width: 15),
              Expanded(
                child: Container(
                  decoration: const BoxDecoration(
                    border: Border(bottom: BorderSide(color: Colors.grey))
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        movie.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,          
                      ),
                      const SizedBox(height: 5),
                      Text(
                        movie.releaseDate,
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          Text(
                            movie.voteAverage,
                            style: const TextStyle(color: Colors.green),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          const SizedBox(width: 5,),
                          Text(
                            movie.voteCount,
                            style: const TextStyle(color: Colors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                      const SizedBox(height: 5),
                      Text(
                        movie.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(
                            color: Colors.white
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(width: 10),
            ],
          ),
        ),
        Material(
          color: Colors.transparent,
          child: InkWell(
            borderRadius: BorderRadius.circular(10),
            onTap: () => model.onMovieTap(context, index),
          ),
        ),
      ],
    );
  }
}







// class ChangePage extends StatefulWidget {
//   const ChangePage({super.key});

//   @override
//   State<ChangePage> createState() => _ChangePageState();
// }

// class _ChangePageState extends State<ChangePage> {
//   int _indexPage = 1;
//   Color containerColor1 = Colors.green;
//   Color containerColor2 = Colors.black;
//   void changeColor(){
//     if(_indexPage == 1){
//       containerColor1 = Colors.green;
//       containerColor2 = Colors.black;
//     }
//     if(_indexPage == 2){
//       containerColor1 = Colors.black;
//       containerColor2 = Colors.green;
//     }
//     setState(() {
      
//     });
//   }
//   @override
//   Widget build(BuildContext context) {
//     return         Stack(
//           children: [
//             Positioned(
//               bottom: 10,
//               left: MediaQuery.sizeOf(context).width / 6,
//               child: Container(
//                 decoration: const BoxDecoration(
//                   boxShadow: [
//                     BoxShadow(color: Colors.black, spreadRadius: 3),
//                   ],
//                 ),
//                 child: Row(
//                   children: [
//                     Container(
//                       width: MediaQuery.sizeOf(context).width / 3,
//                       height: 35,
//                       color: containerColor1,
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(10),
//                         onTap: () {
//                             _indexPage = 1;
//                             changeColor();
//                         },
//                         child: const Center(
//                           child: Text(
//                             "Фильмы",
//                             style: TextStyle(
//                               color: Colors.white
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                     Container(
//                       width: MediaQuery.sizeOf(context).width / 3,
//                       height: 35,
//                       color: containerColor2,
//                       child: InkWell(
//                         borderRadius: BorderRadius.circular(10),
//                         onTap: () {
//                             _indexPage = 2;
//                             changeColor();
//                         },
//                         child: const Center(
//                           child: Text(
//                             "Актёры",
//                           style: TextStyle(
//                             color: Colors.white
//                           ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),

//           ],
//         );
//   }
// }