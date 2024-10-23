import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:search_choices/search_choices.dart';
import 'package:the_movie_db/ui/widgets/cache/cached_images.dart';
import 'package:the_movie_db/ui/widgets/discover/search_model.dart';
import 'package:flutter/foundation.dart' show kIsWeb;

class SearchPageWidget extends StatefulWidget {
  const SearchPageWidget({super.key});

  @override
  State<SearchPageWidget> createState() => _SearchPageWidgetState();
}

class _SearchPageWidgetState extends State<SearchPageWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<SearchViewModel>().setupLocale(locale);
  }
  @override
  Widget build(BuildContext context) {
    
    return const Stack(
      children: [
        _SearchAnotherWidget(),
      ],
    );
  }
}

class _SearchAnotherWidget extends StatefulWidget {
  const _SearchAnotherWidget({super.key});

  @override
  State<_SearchAnotherWidget> createState() => __SearchAnotherWidgetState();
}

class __SearchAnotherWidgetState extends State<_SearchAnotherWidget> {
  String? _searchingWithQuery;
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SearchViewModel>();
    return SearchAnchor(
      viewBackgroundColor: Colors.black,
      builder: (BuildContext context, SearchController controller){
        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SearchBar(
            padding: MaterialStateProperty.all(EdgeInsets.symmetric(horizontal: 8)),
            leading: const Icon(Icons.search, color: Color.fromARGB(255, 155, 155, 155), size: 24,),
            backgroundColor:MaterialStateProperty.all(
              const Color.fromARGB(255, 38, 38, 38),
            ),
            hintText: "Фильмы, сериалы, персоны",
            hintStyle: MaterialStateProperty.all(
              const TextStyle(
                color: Color.fromARGB(255, 155, 155, 155),
                fontSize: 14
              ),
            ),
            trailing: [
              Container(
                decoration: const BoxDecoration(
                  border: Border(left: BorderSide(width: 1))
                ),
                child: IconButton(
                  onPressed: () => model.discoverPage(context),
                  icon: const Icon(
                    Icons.settings, 
                    color: const Color.fromARGB(255, 155, 155, 155),
                    size: 24,
                  )
                )
              ),
            ],
            shape:  MaterialStateProperty.all(const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            )),
            onTap: () {
              controller.openView();
            },
          ),
        );
      }, 
      suggestionsBuilder: (BuildContext context, SearchController controller) async {
        _searchingWithQuery = controller.text;
        await model.search(_searchingWithQuery ?? '');
        if(_searchingWithQuery!.isEmpty){
          return List<Text>.generate(0, (int index){
            return Text('');
          });
        }
        final List<SearchListRowData> options = model.results;
        final _lastOptions = List<ListTile>.generate(options.length, (int index) {
          final item = options[index];
          var titleOrName = item.mediaType == 'movie' ? item.title : item.name;
          var date = '';
          if(item.mediaType == 'movie'){
            date = item.releaseDate ?? '';
          } else if(item.mediaType == 'tv'){
            date = item.firstAirDate ?? '';
          } else {
            date = item.birthday ?? '';
          }
          var originalName;
          if(item.originalName != null && item.originalName!.length > 20){
            originalName = item.originalName!.substring(0, 20) + "...";
          } else{
            originalName = item.originalName;
          }
          if(titleOrName != null && titleOrName!.length > 50){
            titleOrName = titleOrName!.substring(0, 50) + "...";
          }
          final voteAverage =item.voteAverage;
          final voteCount =item.voteCount;
          final popularity =item.popularity;
          final posterPath = item.posterPath;
          final profilePath = item.profilePath;
          return ListTile(
            onTap: () => model.onMovieTap(context, index, options, item.mediaType),
            title: Container(
              padding: EdgeInsets.all(8),
              child: Row(
                  children: [
                    CacheImage(imagePath: posterPath ?? profilePath ?? '', height: 70, width: 70,),
                    Container(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            titleOrName ?? '',
                            style: const TextStyle(
                                fontWeight: FontWeight.bold,
                                color: Colors.white,
                                fontSize: 10,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,          
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [Text(
                                originalName ?? '',
                                style: const TextStyle(color: Colors.grey, fontSize: 10,),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                              Text(
                                originalName != null ? ", $date" : date,
                                style: const TextStyle(color: Colors.grey, fontSize: 10,),
                                maxLines: 1,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: [
                              if(item.mediaType == 'movie' ||
                                item.mediaType == 'tv'
                              )...[
                                Text(
                                  voteAverage ?? '',
                                  style: const TextStyle(color: Colors.green),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                const SizedBox(width: 5,),
                                Text(
                                  voteCount ?? '',
                                  style: const TextStyle(color: Colors.grey),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ] else ...[
                                Text(
                                  popularity.toString(),
                                  style: const TextStyle(color: Colors.green),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ]
                            ],
                          ),        
                        ],
                      ),
                      ),
                  ],
              ),
            ),
          );
        });
        return _lastOptions;
      }
    );
  }
}

class _SearchWidget extends StatefulWidget {
  const _SearchWidget();

  @override
  State<_SearchWidget> createState() => _SearchWidgetState();
}

class _SearchWidgetState extends State<_SearchWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<SearchViewModel>();
    dynamic selectedValueSingleDialogPagedFuture;
    PointerThisPlease<int> currentPage = PointerThisPlease<int>(1);
    return SearchChoices.single(
      hint: "Select one",
      searchHint: "Select one",
      value: selectedValueSingleDialogPagedFuture,
      isExpanded: true,
      currentPage: currentPage,
      onChanged: kIsWeb
            ? null
            : (value) {
                setState(() {
                  selectedValueSingleDialogPagedFuture = value;
                });
              },
      itemsPerPage: 20,
      futureSearchFn: (keyword, orderBy, orderAsc, filters, pageNb) async {
        print(selectedValueSingleDialogPagedFuture);
        return model.searchF(keyword ?? '');
      },

    );
        
  }
}

class searchResult extends StatelessWidget {
  const searchResult({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _MovieListWidget extends StatelessWidget {
  const _MovieListWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<SearchViewModel>();
    return RefreshIndicator(
      onRefresh: () => model.resetList(),
      child: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: model.results.length,
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
    final model = context.read<SearchViewModel>();
    final movieTvPerson = model.results[index];
    final titleOrName = movieTvPerson.mediaType == 'movie' ? movieTvPerson.title : movieTvPerson.name;
    var date = '';
    if(movieTvPerson.mediaType == 'movie'){
      date = movieTvPerson.releaseDate ?? '';
    } else if(movieTvPerson.mediaType == 'tv'){
      date = movieTvPerson.firstAirDate ?? '';
    } else {
      date = movieTvPerson.birthday ?? '';
    }
    final voteAverage =movieTvPerson.voteAverage;
    final voteCount =movieTvPerson.voteCount;
    final popularity =movieTvPerson.popularity;
    final posterPath = movieTvPerson.posterPath;
    final overview = movieTvPerson.overview;
    final profilePath = movieTvPerson.profilePath;
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
              if(profilePath != null)
                CacheImage(imagePath: profilePath, width: 95),             
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
                        titleOrName ?? '',
                        style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,          
                      ),
                      const SizedBox(height: 5),
                      Text(
                        date,
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Row(
                        children: [
                          if(movieTvPerson.mediaType == 'movie' ||
                            movieTvPerson.mediaType == 'tv'
                          )...[
                            Text(
                              voteAverage ?? '',
                              style: const TextStyle(color: Colors.green),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(width: 5,),
                            Text(
                              voteCount ?? '',
                              style: const TextStyle(color: Colors.grey),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ] else ...[
                            Text(
                              popularity.toString(),
                              style: const TextStyle(color: Colors.green),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ]
                        ],
                      ),
                      const SizedBox(height: 5),
                      if(movieTvPerson.mediaType == 'movie' ||
                            movieTvPerson.mediaType == 'tv'
                      )...[
                        Text(
                          overview ?? '',
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          style: const TextStyle(
                              color: Colors.white
                        ),
                      ),
                          ]
                      
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
            onTap: () {
              //model.onMovieTap(context, index);
            },
          ),
        ),
      ],
    );
  }
}






