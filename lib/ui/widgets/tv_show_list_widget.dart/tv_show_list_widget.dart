
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/domain/api_client/image_downloader.dart';
import 'package:the_movie_db/ui/widgets/tv_show_list_widget.dart/tv_show_list_model.dart';


class TWShowListWidget extends StatefulWidget {
  const TWShowListWidget({super.key});

  @override
  State<TWShowListWidget> createState() => _TWShowListWidgetState();
}

class _TWShowListWidgetState extends State<TWShowListWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<TvShowViewModel>().setupLocale(locale);
  }
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _TvShowListWidget(),
        SearchWidget(),
      ],
    );
  }
}

class SearchWidget extends StatelessWidget {
  const SearchWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<TvShowViewModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: model.serachTvShow,
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

class _TvShowListWidget extends StatelessWidget {
  const _TvShowListWidget({
    super.key,
  });

  
  @override
  Widget build(BuildContext context) {
    final model = context.watch<TvShowViewModel>();
    return ListView.builder(
      padding: const EdgeInsets.only(top: 70),
      keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
      itemCount: model.shows.length,
      itemExtent: 163,
      itemBuilder: (BuildContext context, int index) {
        model.showedTvShowAtIndex(index);
        return _TvShowListRowWidget(index: index,);
      },
    );
  }
}


class _TvShowListRowWidget extends StatelessWidget {
  final int index;
  const _TvShowListRowWidget
  ({required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.read<TvShowViewModel>();
    final show = model.shows[index];
    final posterPath = show.posterPath;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
      child: Stack(
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(color: Colors.black.withOpacity(0.2)),
              borderRadius: const BorderRadius.all(Radius.circular(10)),
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
                  Image.network(
                    ImageDownloader.imageUrl(posterPath),
                    width: 95
                  ),                  
                const SizedBox(width: 15),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      Text(
                        show.title,
                        style: const TextStyle(
                            fontWeight: FontWeight.bold),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        show.firstAirDate,
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        show.overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
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
              onTap: () {},
            ),
          ),
        ],
      ),
    );
  }
}