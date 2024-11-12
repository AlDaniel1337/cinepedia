//===========================================================
//* ADAPTACION DEL PAQUETE [youtube_player_flutter]
//LINK - https://pub.dev/packages/youtube_player_flutter
//===========================================================

import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class VideoPlayerPlugin extends StatelessWidget {

  final String youtubeId;
  final String name;
   
  const VideoPlayerPlugin({super.key, required this.youtubeId, required this.name});
  
  @override
  Widget build(BuildContext context) {
    return _YouTubeVideoPlayer(youtubeId: youtubeId, name: name);
  }
}


class _YouTubeVideoPlayer extends StatefulWidget {

  final String youtubeId;
  final String name;

  const _YouTubeVideoPlayer({ required this.youtubeId, required this.name });

  @override
  State<_YouTubeVideoPlayer> createState() => _YouTubeVideoPlayerState();
}

class _YouTubeVideoPlayerState extends State<_YouTubeVideoPlayer> {

  late YoutubePlayerController _controller;  

  @override
  void initState() {
    super.initState();
    
    //* Configuracion para el controlador
    _controller = YoutubePlayerController(
      initialVideoId: widget.youtubeId,
      flags: const YoutubePlayerFlags(
        hideThumbnail: true,
        showLiveFullscreenButton: false,
        mute: false,
        autoPlay: false,
        disableDragSeek: true,
        loop: false,
        isLive: false,
        forceHD: false,
        enableCaption: false,
      ),
    );
  }



  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [

          Text(widget.name),
          YoutubePlayer(controller: _controller)
          
        ],

      )
    );
  }
}