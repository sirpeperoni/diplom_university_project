
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:the_movie_db/ui/navigation/main_navigation.dart';
import 'package:the_movie_db/ui/widgets/cache/cached_images.dart';
import 'package:the_movie_db/ui/widgets/elements/radial_percent_widget.dart';
import 'package:the_movie_db/ui/widgets/tv_show_details/tv_show_details_model.dart';

class TvShowDetailsMainInfoWidget extends StatelessWidget {
  const TvShowDetailsMainInfoWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _TopPosterWidget(),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          child: _TvShowNameWidget(),
        ),
        _ScoreWidget(),
        _SummeryWidget(),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: _OverviewWidget(),
        ),
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 30, vertical: 10),
          child: _DescriptionWidget(),
        ),
        SizedBox(height: 30,),
        _PeopleWidget(),

      ],
    );
  }
}

class _DescriptionWidget extends StatelessWidget {
  const _DescriptionWidget();

  @override
  Widget build(BuildContext context) {
    final overview = context.select((TvShowDetailsModel model) => model.data.overview);
    return Text(
      overview,
      style: const TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400
      ),        
    );
  }
}

class _OverviewWidget extends StatelessWidget {
  const _OverviewWidget();

  @override
  Widget build(BuildContext context) {
    return const Text(
      "Обзор",
      style: TextStyle(
        color: Colors.white,
        fontSize: 16,
        fontWeight: FontWeight.w400
      ),
    );
  }
}

class _TopPosterWidget extends StatelessWidget {

  const _TopPosterWidget();
  @override
  Widget build(BuildContext context) {
    final model = context.read<TvShowDetailsModel>();
    final posterData = context.select((TvShowDetailsModel model) => model.data.posterData);
    final backdorPath = posterData.backdorPath;
    final posterPath = posterData.posterPath;
    return AspectRatio(
      aspectRatio: 390 / 219,
      child: Stack(
        children: [
          if(backdorPath != null)
            CacheImage(imagePath: backdorPath),  
          if(posterPath != null)
            Positioned(
              top: 20,
              left: 20,
              bottom: 20,
              child: CacheImage(imagePath: posterPath, width: 95)
            ),
        ],
      ),
    );
  }
}


class _TvShowNameWidget extends StatelessWidget {
  const _TvShowNameWidget();

  @override
  Widget build(BuildContext context) {
    final data = context.select((TvShowDetailsModel model) => model.data.nameData);
  
    return Center(
      child: RichText(
        maxLines: 3,
        textAlign: TextAlign.center,
        text: TextSpan(
          children: [
            TextSpan(
              text: data.name,
              style: const TextStyle(
                fontWeight: FontWeight.w600,
                fontSize: 20.85
              ),
            ),
            TextSpan(
              text: data.year,
              style: const TextStyle(
                fontWeight: FontWeight.w200,
                fontSize: 16
              ),
            )
          ]
        )
      ),
    );
  }
}

class _ScoreWidget extends StatelessWidget {
  const _ScoreWidget();

  @override
  Widget build(BuildContext context) {
    final scoreData = context.select((TvShowDetailsModel model) => model.data.scoreData);
    final trailerKey = scoreData.trailerKey;
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        TextButton(
          onPressed: () {},
          child: Row(
            children: [
              SizedBox(
                width: 40,
                height: 40,
                child: RadialPercentWidget(
                  percent: scoreData.voteAverage / 100,
                  fillColor: const Color.fromARGB(255, 10, 23, 25),
                  lineColor: const Color.fromARGB(255, 37, 203, 103),
                  freeColor: const Color.fromARGB(255, 25, 54, 31),
                  lineWidth: 3,
                  child: Text(scoreData.voteAverage.toStringAsFixed(0)),
                ),
              ),
              const SizedBox(width: 10),
              const Text('User Score'),
            ],
          ),
        ),
        Container(width: 1, height: 15, color: Colors.grey),
        trailerKey != null
            ? TextButton(
                onPressed: () => Navigator.of(context).pushNamed(
                  MainNavigationRoutesName.movieTrailerWidget,
                  arguments: trailerKey,
                ),
                child: const Row(
                  children: [
                    Icon(Icons.play_arrow),
                    Text('Play Trailer'),
                  ],
                ),
              )
            : const SizedBox.shrink(),
      ],
    );
  }
}

class _SummeryWidget extends StatelessWidget {
  
  const _SummeryWidget();

  @override
  Widget build(BuildContext context) {
    final summary = context.select((TvShowDetailsModel model) => model.data.summary);

    return ColoredBox(
      color: const Color.fromRGBO(22, 21, 25, 1.0),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
        child: Text(
          summary,
          //"12A, 01/03/2024 (GB) фантастика, приключения, 2h 46m",
          maxLines: 3,
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w200,
            fontSize: 16
          ),
        ),
      ),
    );
  }
}


class _PeopleWidget extends StatelessWidget {
  const _PeopleWidget();

  @override
  Widget build(BuildContext context) {
    var crew = context.select((TvShowDetailsModel model) => model.data.peopleData);
    if(crew.isEmpty) return const SizedBox.shrink();


    return  Column(
      children: crew
        .map(
          (chunk) => Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: _PeopleWidgetRow(employees: chunk),
          )
        ).toList()
    );
  }
}


class _PeopleWidgetRow extends StatelessWidget {
  const _PeopleWidgetRow({required this.employees});
  final List<TvShowDetailsPeopleData> employees;
  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: const EdgeInsets.only(right: 30, left: 30),
      child: Row(
              mainAxisSize: MainAxisSize.max,
              children: employees.map((employee) => _PeopleWidgetRowItem(employee: employee,)).toList()
            ),
    );   
  }
}

class _PeopleWidgetRowItem extends StatelessWidget {
  final TvShowDetailsPeopleData employee;
  const _PeopleWidgetRowItem({required this.employee});
  
  @override
  Widget build(BuildContext context) {
    const nameStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w200,
      fontSize: 16
    );
    const jobTitleStyle = TextStyle(
      color: Colors.white,
      fontWeight: FontWeight.w200,
      fontSize: 16
    );
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(employee.name, style: nameStyle),
                      Text(employee.job, style: jobTitleStyle)
                    ],
                  ),
    );
  }
}