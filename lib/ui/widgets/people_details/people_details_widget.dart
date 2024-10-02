import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/cache/cached_images.dart';
import 'package:the_movie_db/ui/widgets/people_details/people_details_model.dart';

class PeopleDetailsWidget extends StatefulWidget {
  const PeopleDetailsWidget({super.key});

  @override
  State<PeopleDetailsWidget> createState() => _PeopleDetailsWidgetState();
}

class _PeopleDetailsWidgetState extends State<PeopleDetailsWidget> {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale =Localizations.localeOf(context);
    Future.microtask(
      () => context.read<PeopleDetailsViewModel>().setupLocale(context, locale)
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget()
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(255, 255, 255, 1),
        child: _BodyWidget()
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final title = context.select((PeopleDetailsViewModel model) => model.data.name);
    return Text(title, style: const TextStyle(color: Colors.white),);
  }
}

class _BodyWidget
 extends StatelessWidget {
  const _BodyWidget
  ();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((PeopleDetailsViewModel model) => model.data.isLoading);
    final model = context.read<PeopleDetailsViewModel>();
    if(isLoading){
      return const Center(child: CircularProgressIndicator());
    }
    final photo = model.data.profilePath; 
    return ListView(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if(photo != null)
                  CacheImage(imagePath: photo, width: MediaQuery.sizeOf(context).width / 2,), 
                SizedBox(
                  width: MediaQuery.sizeOf(context).width / 2,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(model.data.name, style: const TextStyle(fontWeight: FontWeight.bold),),
                      const Text("Биография: ", style: TextStyle(fontWeight: FontWeight.bold),),
                      Text(model.data.biography, softWrap: true,),
                    ],
                  )
                ),
                
              ],
            )

          ],
        );
  }
}


