import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/cache/cached_images.dart';
import 'package:the_movie_db/ui/widgets/people/people_list_view_model.dart';


class PeopleListWidget extends StatefulWidget {
  const PeopleListWidget({super.key});

  @override
  State<PeopleListWidget> createState() => _PeopleListWidgetState();
}

class _PeopleListWidgetState extends State<PeopleListWidget> {

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<PeopleListViewModel>().setupLocale(locale);
  }
  @override
  Widget build(BuildContext context) {
    return const Stack(
      children: [
        _PeopleListWidget(),
      ],
    );
  }
}

class _SearchWidget extends StatelessWidget {
  const _SearchWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PeopleListViewModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: model.searchPeople,
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

class _PeopleListWidget extends StatelessWidget {
  const _PeopleListWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<PeopleListViewModel>();
    return RefreshIndicator(
      onRefresh: () => model.resetList(),
      child: ListView.builder(
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        itemCount: model.people.length,
        itemExtent: 163,
        itemBuilder: (BuildContext context, int index) {
          model.showedPeopleAtIndex(index);
          return _PeopleListRowWidget(index: index);
        },
      ),
    );
  }
}


class _PeopleListRowWidget extends StatelessWidget {
  final int index;
  const _PeopleListRowWidget
  ({required this.index});

  @override
  Widget build(BuildContext context) {
    final model = context.read<PeopleListViewModel>();
    final person = model.people[index];
    final profilePath = person.profilePath;
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
                        person.name,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        person.originalName,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          color: Colors.white
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 5),
                      Text(
                        person.knownForDepartment,
                        style: const TextStyle(color: Colors.grey),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        person.popularity.toString(),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: const TextStyle(color: Colors.green),
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
            onTap: () => model.onPersonTap(context, index),
          ),
        ),
      ],
    );
  }
}


