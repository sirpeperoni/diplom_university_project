import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/discover/discover_model.dart';
import 'package:flutter_spinner_item_selector/flutter_spinner_item_selector.dart';

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
            Expanded(child: GenresListWidget()),]
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
        const GenreListIsNotOpenWidget(),
        const CountriesListIsNotOpenWidget(),
        const YearPickerIsNotOpenWidget(),
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
  GenresListWidget({super.key});

  @override
  State<GenresListWidget> createState() => _GenresListWidgetState();
}

class _GenresListWidgetState extends State<GenresListWidget> {
    @override

  @override
  Widget build(BuildContext context) {
 
    final model = context.watch<DiscoverViewModel>();
    return Column(
      children: [
        Expanded(
          child: ListView.builder(
            primary: false,
            physics: const AlwaysScrollableScrollPhysics (),
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
                  padding: const EdgeInsets.only(top: 10, bottom: 10, left: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(0.2))),
                  ),
                  clipBehavior: Clip.hardEdge,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(genre, style: TextStyle(color: Colors.white),),
                      choose ? const Icon(Icons.check, color: Color.fromARGB(255, 255, 94, 0),) : const SizedBox.shrink()
                    ],
                  )
                ),
              );
            },
                ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width,
          child: ElevatedButton(
            onPressed: () => model.changeGenre(),
            child: Text("Выбрать"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 255, 94, 0),
            ),
          )
        ),
      ],
    );
  }
}


class GenreListIsNotOpenWidget extends StatelessWidget {
  const GenreListIsNotOpenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<DiscoverViewModel>();
    final toggleGenres = model.toggleGenres.map((e) => e.genre.name).toList().join(', ');
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
            model.toggleGenres.isEmpty ? const Text("любые") : Text(toggleGenres),
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
            primary: false,
            physics: const AlwaysScrollableScrollPhysics (),
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
                  padding: const EdgeInsets.only(bottom: 10, top: 10, left: 10),
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(255, 0, 0, 0),
                    border: Border(bottom: BorderSide(color: Colors.white.withOpacity(0.2))),
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
                      Text(country ?? '', style: const TextStyle(color: Colors.white),),
                      choose == true ? const Icon(Icons.check, color: Color.fromARGB(255, 255, 94, 0),) : const SizedBox.shrink()
                    ],
                  )
                ),
              );
            },
                ),
        ),
        Container(
          width: MediaQuery.sizeOf(context).width,
          child: ElevatedButton(
            onPressed: () => model.changeCountries(),
            child: Text("Выбрать"),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: Color.fromARGB(255, 255, 94, 0),
            ),
          )
        ),
      ],
    );
  }
}


class CountriesListIsNotOpenWidget extends StatelessWidget {
  const CountriesListIsNotOpenWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final model = context.read<DiscoverViewModel>();
    final toggleCountries = model.toggleCountry.map((e) => e.country.nativeName).toList().join(', ');
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
            model.toggleCountry.isEmpty ? const Text("любые") : Text(toggleCountries),
          ],
        ),
      ),
    );
  }
}


class YearPickerIsNotOpenWidget extends StatefulWidget {
  const YearPickerIsNotOpenWidget({super.key});

  @override
  State<YearPickerIsNotOpenWidget> createState() => _YearPickerIsNotOpenWidgetState();
}

class _YearPickerIsNotOpenWidgetState extends State<YearPickerIsNotOpenWidget> {
  String showYear = 'Select Year';
  final DateTime _selectedYear = DateTime.now();
  void F(){
    showDialog(
      context: context,
       builder: (BuildContext context){
        return AlertDialog(
          insetPadding: const EdgeInsets.all(0),
          iconPadding: const EdgeInsets.all(0),
          actionsPadding: const EdgeInsets.all(0),
          buttonPadding: const EdgeInsets.all(0),
          title: const Text("Год"),
          content: SizedBox(
            width: 200,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                SpinnerItemSelector(
                  items: const [
                            "1900",
                            "1902",
                            "1903",
                            "1904",
                            "1905",
                        ],
                  scrollAxis: Axis.vertical,
                  height: 200,
                  width: 50,
                  itemHeight: 50,
                  itemWidth: 100,
                  selectedItemToWidget: (item) => Text(item),
                  nonSelectedItemToWidget: (item) => Opacity(opacity: 0.4, child: Text(item)),
                  onSelectedItemChanged: (item) {
                            
                        },
                  spinnerBgColor: Colors.white
                ),
                SpinnerItemSelector<Widget>(
                  items: const [
                            Text("1901"),
                            Text("1902"),
                            Text("1903"),
                            Text("1904"),
                            Text("1905"),
                        ],
                  scrollAxis: Axis.vertical,
                  height: 200,
                  width: 50,
                  itemHeight: 50,
                  itemWidth: 50,
                  selectedItemToWidget: (item) => item,
                  nonSelectedItemToWidget: (item) => Opacity(opacity: 0.4, child: item as Text),
                  onSelectedItemChanged: (item) {
                            // handle selected item 
                        },
                  spinnerBgColor: Colors.white
                ),
              ],
            ),
          ),
        );
       }
    );
  }
  

  @override
  Widget build(BuildContext context) {
    final model = context.read<DiscoverViewModel>();
    final fromYear = context.select((DiscoverViewModel model) => model.fromYear);
    dynamic lastYear;

    return InkWell(
      onTap: () {
        
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.blueAccent)
        ),
        child:const Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text("Страны"),
            Text("любой"),
          ],
        ),
      ),
    );
  }
}





// Future flutterYearPicker(BuildContext context) async{
//   return showDialog(
//     context: context,
//     builder: (context) {
//       final Size size = MediaQuery.of(context).size;
//       return AlertDialog(
//         title: Column(
//           children: const [
//             Text('Select a Year'),
//             Divider(thickness: 1,)
//           ],
//         ),
//         contentPadding: const EdgeInsets.all(10),
//         content: SizedBox(
//           height: size.height / 3,
//           width: size.width,
//           child: GridView.count(
//             physics: const BouncingScrollPhysics(),
//             crossAxisCount: 3,
//             children: [
//               ...List.generate(
//                 123,
//                     (index) => InkWell(
//                   onTap: () {
//                     log("Selected Year ==> ${(2022 - index).toString()}");
//                     Navigator.pop(context);
//                   },
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 0),
//                     child: Chip(
//                       label: Container(
//                         padding: const EdgeInsets.all(5),
//                         child: Text(
//                           (2022 - index).toString(),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       );
//     },
//   );
// }