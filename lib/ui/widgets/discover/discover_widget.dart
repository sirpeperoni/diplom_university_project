import 'package:flutter/material.dart';
import 'package:flutter_holo_date_picker/flutter_holo_date_picker.dart';
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
            const Expanded(child: CountriesListWidget()),]
          else if(isChooseGenres && !isChooseCountries) ...[
            const Expanded(child: GenresListWidget()),]
          else ...[
            const SearchMenuWidget(),
          ]
      ]);
  }
}


class SearchMenuWidget extends StatefulWidget {
  const SearchMenuWidget({super.key});

  @override
  State<SearchMenuWidget> createState() => _SearchMenuWidgetState();
}

class _SearchMenuWidgetState extends State<SearchMenuWidget> {
  @override
  Widget build(BuildContext context) {
    final model = context.watch<DiscoverViewModel>();
    return Column(
      children: [
        const GenreListIsNotOpenWidget(),
        const CountriesListIsNotOpenWidget(),
        const YearPickerIsNotOpenWidget(),
        Container(height: 10, 
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.grey, width: 0.2))
        ),),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, top: 10),
                    child: Text("Рейтинг", style: const TextStyle(color: Colors.white)),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(right: 10, top: 10),
                    child: (model.min == 0 && model.max == 10) ? const Text("неважно", style: const TextStyle(color: Colors.white)) 
                      : Text(model.rating, style: const TextStyle(color: Colors.white)),
                  ),
                ],
              ),
              RangeSlider(
                values: model.currentRangeValues,
                divisions: 10,
                max: 10,
                min: 0,
                labels: RangeLabels(
                  model.currentRangeValues.start.round().toString(),
                  model.currentRangeValues.end.round().toString(),
                ),
                onChanged: (RangeValues values){
                  model.changeCurrentRangeValues(values);
                }
              ),
            ],
          ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: ElevatedButton(
            onPressed: () => model.onSubmitTap(context),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 255, 94, 0),
            ),
            child: const Text("Показать"),
          )
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
                      Text(genre, style: const TextStyle(color: Colors.white),),
                      choose ? const Icon(Icons.check, color: Color.fromARGB(255, 255, 94, 0),) : const SizedBox.shrink()
                    ],
                  )
                ),
              );
            },
                ),
        ),
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: ElevatedButton(
            onPressed: () => model.changeGenre(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 255, 94, 0),
            ),
            child: const Text("Выбрать"),
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
        decoration: const BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: 0.1))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Жанры", style: TextStyle(color: Colors.white)),
            model.toggleGenres.isEmpty ? const Text("любые", style: TextStyle(color: Colors.white)) : Text(toggleGenres,style: const TextStyle(color: Colors.white)),
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
        SizedBox(
          width: MediaQuery.sizeOf(context).width,
          child: ElevatedButton(
            onPressed: () => model.changeCountries(),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white,
              backgroundColor: const Color.fromARGB(255, 255, 94, 0),
            ),
            child: const Text("Выбрать"),
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
        decoration: const BoxDecoration(
          border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: 0.1))
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            const Text("Страны", style: TextStyle(color: Colors.white)),
            model.toggleCountry.isEmpty ? const Text("любые", style: TextStyle(color: Colors.white)) : Text(toggleCountries, style: const TextStyle(color: Colors.white)),
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
  @override
  Widget build(BuildContext context) {

  Future<DateTime?> show(BuildContext context){
    var discoverState = Provider.of<DiscoverViewModel>(context, listen: false);
    return showDialog(
      context: context,
      builder: (context) {
        return ChangeNotifierProvider.value(
          value: discoverState,
          child: const YearSpinner(),
        );
      }
    );
  }
  final model = context.watch<DiscoverViewModel>();
  return InkWell(
    onTap: () async {
      //showYearPicker();
      show(context);
    },
    child: Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      decoration: const BoxDecoration(
        border: Border.symmetric(horizontal: BorderSide(color: Colors.grey, width: 0.1))
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Год", style: TextStyle(color: Colors.white),),
          (model.selectedFromYear == 1887 && model.selectedToYear == DateTime.now().year) ? const Text("любые", style: TextStyle(color: Colors.white))
            : Text(model.primaryRelease, style: const TextStyle(color: Colors.white))
        ],
      ),
    ),
  );
  }
}

class YearSpinner extends StatelessWidget {
  const YearSpinner({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final model = context.watch<DiscoverViewModel>();
    return AlertDialog(
      title: const Text("Год", style: TextStyle(color: Colors.white)),
      contentPadding: const EdgeInsets.symmetric(vertical: 20, horizontal: 0),
      backgroundColor: const Color.fromARGB(255, 38, 38, 38),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(0))),
      
      actions: [
        TextButton(onPressed: (){
          
        }, child: Text("Сбросить", style: TextStyle(color: Colors.white))),
        TextButton(onPressed: (){
          model.acceptChangeYear();
          Navigator.of(context).pop();
        }, child: Text("Выбрать", style: TextStyle(color: Colors.white))),
      ],
      content: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 100,
            child: DatePickerWidget(
              firstDate: DateTime(1887),
              lastDate: DateTime.now(),
              initialDate: DateTime(model.selectedFromYear),
              dateFormat: "yyyy",
              locale: DateTimePickerLocale.ru,
              looping: true,
              pickerTheme: const DateTimePickerTheme(
                backgroundColor: Color.fromARGB(255, 38, 38, 38),
                itemTextStyle: TextStyle(color: Colors.white),
              ),
              onChange: (DateTime newDate, _){
                model.changeFromYear(newDate.year);
              },
            ),
          ),
          Container(
            width: 100,
            child: DatePickerWidget(
              firstDate: DateTime(1887),
              lastDate: DateTime.now(),
              initialDate: DateTime(model.selectedToYear),
              dateFormat: "yyyy",
              locale: DateTimePickerLocale.ru,
              looping: true,
              pickerTheme: const DateTimePickerTheme(
                backgroundColor: Color.fromARGB(255, 38, 38, 38),
                itemTextStyle: TextStyle(color: Colors.white),
              ),
              onChange: (DateTime newDate, _){
                model.changeToYear(newDate.year);
              },
            ),
          ),
        ],
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