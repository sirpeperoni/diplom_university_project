import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/domain/api_client/image_downloader.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';
import 'package:the_movie_db/ui/widgets/people/people_list_view_model.dart';
import 'package:the_movie_db/ui/widgets/people_details/people_details_model.dart';

class MovieDetailsMainScreenCastWidget extends StatelessWidget {
  // ignore: use_super_parameters
  const MovieDetailsMainScreenCastWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.white,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.all(10.0),
            child: Text(
              'Series Cast',
              style: TextStyle(
                fontSize: 17,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(
            height: 250,
            child: Scrollbar(
              child: _ActorListWidget(),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(3.0),
            child: TextButton(
              onPressed: () {},
              child: const Text('Full Cast & Crew'),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActorListWidget extends StatelessWidget {
  const _ActorListWidget();

  @override
  Widget build(BuildContext context) {
    var data = context.select((MovieDetailsModel model) => model.data.actorsData);
    if (data.isEmpty) return const SizedBox.shrink();
    return ListView.builder(
      itemCount: data.length,
      itemExtent: 150,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return _ActorListItemWidget(actorIndex: index);
      },
    );
  }
}

class _ActorListItemWidget extends StatelessWidget {
  final int actorIndex;
  const _ActorListItemWidget({
    required this.actorIndex,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.read<MovieDetailsModel>();
    final actor = model.data.actorsData[actorIndex];
    final id = model.data.actorsData[actorIndex].id;
    final profilePath = actor.profilePath;
    final peopleModel = context.read<PeopleListViewModel>();
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DecoratedBox(
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
        child: ClipRRect(
          borderRadius: const BorderRadius.all(Radius.circular(8)),
          clipBehavior: Clip.hardEdge,
          child: Material(
            child: InkWell(
              onTap: () {peopleModel.onPersonTapInMovieDetails(context, id);},
              child: IgnorePointer(
                child: Column(
                  children: [
                    if(profilePath != null)
                      Image.network(
                        ImageDownloader.imageUrl(profilePath),
                        width: 150,
                        height: 120,
                        fit: BoxFit.fitWidth,
                      ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              actor.name,
                              maxLines: 2,
                              style: const TextStyle(fontSize: 14),
                            ),
                            const SizedBox(height: 7),
                            Text(
                              actor.character,
                              maxLines: 3,
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}