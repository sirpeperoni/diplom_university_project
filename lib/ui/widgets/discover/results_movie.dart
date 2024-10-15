import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/cache/cached_images.dart';
import 'package:the_movie_db/ui/widgets/discover/results_model.dart';


class ResultDiscoverMovieListWidget extends StatefulWidget {
  const ResultDiscoverMovieListWidget({super.key});

  @override
  State<ResultDiscoverMovieListWidget> createState() => _ResultDiscoverMovieListWidgetState();
}

class _ResultDiscoverMovieListWidgetState extends State<ResultDiscoverMovieListWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<ResultsModel>().setupLocale(locale);
  }
  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((ResultsModel model) => model.isLoading);
    if(isLoading){
      return const Center(child: CircularProgressIndicator());
    }
    return Scaffold(
      appBar: AppBar(
        title: const Text("Результаты", style: TextStyle(color: Colors.white,)),
        foregroundColor: Colors.white,
      ),
      backgroundColor: Colors.black,
      body: const _MovieListWidget()
    );
  }
}



class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<ResultsModel>();
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
    final model = context.read<ResultsModel>();
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


