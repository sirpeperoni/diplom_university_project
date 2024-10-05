import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/discover/discover_model.dart';

class DiscoverWidget extends StatelessWidget {
  const DiscoverWidget({super.key});
  
  @override
  Widget build(BuildContext context) {
    final isChooseCountries = context.select((DiscoverViewModel model) => model.isChooseCountries);
    final isChooseGenres = context.select((DiscoverViewModel model) => model.isChooseGenre);
    return Scaffold(
      body: Column(children:[ 
        isChooseCountries && !isChooseGenres ?  SizedBox.shrink() : Expanded(child: GenresListWidget()),
        isChooseGenres && !isChooseCountries ?  SizedBox.shrink() : Expanded(child: CountriesListWidget()),
      ]),
    );
  }
}



class GenresListWidget extends StatefulWidget {
  const GenresListWidget({super.key});

  @override
  State<GenresListWidget> createState() => _GenresListWidgetState();
}

class _GenresListWidgetState extends State<GenresListWidget> {
    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<DiscoverViewModel>().setupLocale(context, locale);
  }
  @override
  Widget build(BuildContext context) {
 
    final model = context.watch<DiscoverViewModel>();
    final isChoose = context.select((DiscoverViewModel model) => model.isChooseGenre);
    if(!isChoose){
      return const GenreListIsNotOpenWidget();
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: model.genres.length,
            itemBuilder: (BuildContext context, int index) {
              final genre = model.genres[index].genre.name;
              var choose = model.genres[index].choose;
              return InkWell(
                onTap: () {
                  model.toggleGenre(index);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(genre),
                      choose ? Icon(Icons.check) : SizedBox.shrink()
                    ],
                  )
                ),
              );
            },
                ),
        ),
        TextButton(onPressed: () => model.changeGenre(), child: const Text("Выбрать")),
      ],
    );
  }
}


class GenreListIsNotOpenWidget extends StatelessWidget {
  const GenreListIsNotOpenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<DiscoverViewModel>();
    final _toggleGenres = model.toggleGenres.map((e) => e.genre.name).toList().join(', ');
    return InkWell(
      onTap: () {
        model.changeGenre();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Жанры"),
            model.toggleGenres.isEmpty ? const Text("любые") : Text(_toggleGenres),
          ],
        ),
      ),
    );
  }
}


class CountriesListWidget extends StatefulWidget {
  const CountriesListWidget({super.key});

  @override
  State<CountriesListWidget> createState() => _CountriesListWidgetState();
}

class _CountriesListWidgetState extends State<CountriesListWidget> {
    @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<DiscoverViewModel>().setupLocale(context, locale);
  }
  @override
  Widget build(BuildContext context) {
 
    final model = context.watch<DiscoverViewModel>();
    final isChoose = context.select((DiscoverViewModel model) => model.isChooseCountries);
    if(!isChoose){
      return const CountriesListIsNotOpenWidget();
    }
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: model.countries.length,
            itemBuilder: (BuildContext context, int index) {
              final country = model.countries[index].country.nativeName;
              var choose = model.countries[index].choose;
              return InkWell(
                onTap: () {
                  model.toggleCountryFunc(index);
                },
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.white,
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
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(country),
                      choose ? Icon(Icons.check) : SizedBox.shrink()
                    ],
                  )
                ),
              );
            },
                ),
        ),
        TextButton(onPressed: () => model.changeCountries(), child: const Text("Выбрать")),
      ],
    );
  }
}


class CountriesListIsNotOpenWidget extends StatelessWidget {
  const CountriesListIsNotOpenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<DiscoverViewModel>();
    final _toggleCountries = model.toggleCountry.map((e) => e.country.nativeName).toList().join(', ');
    return InkWell(
      onTap: () {
        model.changeCountries();
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Страны"),
            model.toggleCountry.isEmpty ? const Text("любые") : Text(_toggleCountries),
          ],
        ),
      ),
    );
  }
}