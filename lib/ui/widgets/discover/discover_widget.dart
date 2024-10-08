import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/discover/discover_model.dart';

class DiscoverWidget extends StatefulWidget {
  const DiscoverWidget({super.key});

  @override
  State<DiscoverWidget> createState() => _DiscoverWidgetState();
}

class _DiscoverWidgetState extends State<DiscoverWidget> {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale = Localizations.localeOf(context);
    context.read<DiscoverViewModel>().setupLocale(context, locale);
  }
  @override
  Widget build(BuildContext context) {
    final isChooseCountries = context.select((DiscoverViewModel model) => model.isChooseCountries);
    final isChooseGenres = context.select((DiscoverViewModel model) => model.isChooseGenre);
    return 
      Column(
        children:[ 
          if(isChooseCountries && !isChooseGenres) ...[
            const Expanded(child: GenresListWidget()),]
          else if(isChooseGenres && !isChooseCountries) ...[
            const Expanded(child: CountriesListWidget()),]
          else ...[
            const SearchMenuWidget(),
          ]
      ]);
  }
}


class SearchMenuWidget extends StatelessWidget {
  const SearchMenuWidget({super.key});
  @override
  Widget build(BuildContext context) {
    final model = context.read<DiscoverViewModel>();
    return Column(
      children: [
        GenreListIsNotOpenWidget(),
        CountriesListIsNotOpenWidget(),
        Container(
          width: 50,
          height: 50,
          color: Colors.amber,
          child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(10),
                  onTap: () => model.onSubmitTap(context),
                ),
              ),
        ),
      ],
    );
  }
}


class _SearchInCountryWidget extends StatelessWidget {
  const _SearchInCountryWidget();

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DiscoverViewModel>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: TextField(
        onChanged: model.searchCountry,
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

class SubmitButtonWidget extends StatelessWidget {
  const SubmitButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<DiscoverViewModel>();
    return  Container(
      width: 50,
      height: 50,
      color: Colors.red,
      child: Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(10),
                onTap: () => model.onSubmitTap(context),
              ),
            ),
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

  @override
  Widget build(BuildContext context) {
 
    final model = context.watch<DiscoverViewModel>();
    final isChoose = context.select((DiscoverViewModel model) => model.isChooseGenre);
    // if(!isChoose){
    //   return const GenreListIsNotOpenWidget();
    // }
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
                      choose ? const Icon(Icons.check) : const SizedBox.shrink()
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

  @override
  Widget build(BuildContext context) {
 
    final model = context.watch<DiscoverViewModel>();
    return Column(
      children: [
        const _SearchInCountryWidget(),
        Expanded(
          child: ListView.builder(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            itemCount: model.seacrhCountry.length,
            itemBuilder: (BuildContext context, int index) {
              final country = model.seacrhCountry[index]?.country.nativeName;
              var choose = model.seacrhCountry[index]?.choose;
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
                      Text(country ?? ''),
                      choose == true ? const Icon(Icons.check) : const SizedBox.shrink()
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