import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_detail_main_info_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_detail_main_screen_cast_widget.dart';
import 'package:the_movie_db/ui/widgets/movie_details/movie_details_model.dart';

class MovieDetailsWidget extends StatefulWidget {
  const MovieDetailsWidget({super.key});

  @override
  State<MovieDetailsWidget> createState() => _MovieDetailsWidgetState();
}

class _MovieDetailsWidgetState extends State<MovieDetailsWidget> {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale =Localizations.localeOf(context);
    Future.microtask(
      // ignore: use_build_context_synchronously
      () => context.read<MovieDetailsModel>().setupLocale(context, locale)
    );
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const _TitleWidget(),
        foregroundColor: Colors.white,
      ),
      body: const ColoredBox(
        color: Color.fromRGBO(24, 23, 27, 1.0),
        child: _BodyWidget()
      ),
    );
  }
}

class _TitleWidget extends StatelessWidget {
  const _TitleWidget();

  @override
  Widget build(BuildContext context) {
    final title = context.select((MovieDetailsModel model) => model.data.title);
    return Text(title, style: const TextStyle(color: Colors.white),);
  }
}

class _BodyWidget
 extends StatelessWidget {
  const _BodyWidget
  ();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((MovieDetailsModel model) => model.data.isLoading);
    if(isLoading){
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
          children: const [
            MovieDetailsMainInfoWidget(),
            SizedBox(height: 30,),
            MovieDetailsMainScreenCastWidget(),
          ],
        );
  }
}