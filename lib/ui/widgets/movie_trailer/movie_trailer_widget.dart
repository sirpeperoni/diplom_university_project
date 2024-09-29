
import 'package:flutter/material.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class MovieTrailerWidget extends StatefulWidget {
  const MovieTrailerWidget({super.key, required this.youtubeKey});
  final String youtubeKey;
  @override
  State<MovieTrailerWidget> createState() => _MovieTrailerWidgetState();
}

class _MovieTrailerWidgetState extends State<MovieTrailerWidget> {
  late final YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    
    _controller = YoutubePlayerController.fromVideoId(
      videoId: widget.youtubeKey,
      autoPlay: true,
      params: const YoutubePlayerParams(
        showControls: true,
        mute: false
      ),
    );

  }

  @override
  Widget build(BuildContext context) {
    return YoutubePlayerScaffold(
      controller: _controller,
      builder: (context, player) {
        return Scaffold(
          appBar: AppBar(
            title: const Text('Трейлер'),
          ),
          body: Center(
            child: player,
          ),
        );
      },
    );
  }
}