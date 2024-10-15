import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/widgets/tv_show_details/tv_show_detail_main_info_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_show_details/tv_show_detail_main_screen_cast_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_show_details/tv_show_details_model.dart';

class TvShowDetailsWidget extends StatefulWidget {
  const TvShowDetailsWidget({super.key});

  @override
  State<TvShowDetailsWidget> createState() => _TvShowDetailsWidgetState();
}

class _TvShowDetailsWidgetState extends State<TvShowDetailsWidget> {


  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final locale =Localizations.localeOf(context);
    Future.microtask(
      () => context.read<TvShowDetailsModel>().setupLocale(context, locale)
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
    final title = context.select((TvShowDetailsModel model) => model.data.name);
    return Text(title, style: const TextStyle(color: Colors.white),);
  }
}

class _BodyWidget
 extends StatelessWidget {
  const _BodyWidget
  ();

  @override
  Widget build(BuildContext context) {
    final isLoading = context.select((TvShowDetailsModel model) => model.data.isLoading);
    if(isLoading){
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(
          children: const [
            TvShowDetailsMainInfoWidget(),
            SizedBox(height: 30,),
            TvShowDetailsMainScreenCastWidget(),
          ],
        );
  }
}