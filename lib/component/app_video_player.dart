import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppVideoPlayer extends StatefulWidget {
  final bool isNetwork;
  final String video;
  final String thumbnail;
  final bool showControls;
  final BorderRadiusGeometry? radius;
  final bool isCircle;
  final bool isFullScreen;
  final double loadingWidth;
  final Function(int currentDuration, int totalDuration) durations;
  final Function(double percent)? percentOfCompletion;

  const AppVideoPlayer._internal(
      {super.key,
      required this.isNetwork,
      required this.video,
      required this.thumbnail,
      required this.showControls,
      this.radius,
      required this.isCircle,
      this.isFullScreen = false,
      this.loadingWidth = 400,
      required this.durations,
      this.percentOfCompletion});

  factory AppVideoPlayer.basic(
          {Key? key,
          bool network = false,
          required String video,
          required String thumbnail,
          required double loadingWidth,
          bool showControls = false,
          BorderRadiusGeometry? radius,
          required Function(int currentDuration, int totalDuration) durations,
          required Function(double percent) percentOfCompletion}) =>
      AppVideoPlayer._internal(
        key: key,
        isNetwork: network,
        video: video,
        thumbnail: thumbnail,
        showControls: showControls,
        radius: radius,
        isFullScreen: true,
        isCircle: false,
        durations: durations,
        loadingWidth: loadingWidth,
        percentOfCompletion: percentOfCompletion,
      );

  @override
  State<AppVideoPlayer> createState() => _AppVideoPlayerState();
}

class _AppVideoPlayerState extends State<AppVideoPlayer> {
  late VideoPlayerController videoController;
  late ChewieController chewieController;
  double? complatedVideoPercent;
  bool readyToPlay = false;

  @override
  void initState() {
    if(!widget.isNetwork) {
      videoController = VideoPlayerController.asset(widget.video)
        ..initialize().then((_) {
          videoController.setVolume(0);
          _startListeningToDurations();
          setState(() {
            readyToPlay = true;
            chewieController = ChewieController(
                videoPlayerController: videoController,
                showControls: widget.showControls,
                autoPlay: true,
                looping: true,
                draggableProgressBar: true,
                showControlsOnInitialize: false);
          });
        });
    } else {
      videoController = VideoPlayerController.networkUrl(Uri.parse(widget.video))
        ..initialize().then((_) {
          videoController.setVolume(0);
          _startListeningToDurations();
          setState(() {
            readyToPlay = true;
            chewieController = ChewieController(
                videoPlayerController: videoController,
                showControls: widget.showControls,
                autoPlay: true,
                looping: true,
                draggableProgressBar: true,
                showControlsOnInitialize: false);
          });
        });
    }

    super.initState();
  }

  void _startListeningToDurations() {
    videoController.addListener(() {
      double percent = double.parse((videoController.value.position.inSeconds /
              videoController.value.duration.inSeconds)
          .toStringAsFixed(2));

      if (percent != complatedVideoPercent) {
        setState(() {
          complatedVideoPercent = percent;
        });

        if (widget.percentOfCompletion != null) {
          widget.percentOfCompletion!(complatedVideoPercent ?? 0.0);
        }
      }
    });
  }

  @override
  void dispose() {
    chewieController.dispose();
    videoController.dispose();

    setState(() {
      readyToPlay = false;
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: videoController.value.isInitialized
          ? SizedBox(
              width: context.logicalWidth,
              height: context.logicalHeight,
              child: ClipRRect(
                borderRadius:
                    widget.radius ?? const BorderRadius.all(Radius.circular(0)),
                child: FittedBox(
                    fit: BoxFit.cover,
                    alignment: Alignment.center,
                    child: SizedBox(
                        width: videoController.value.size.width,
                        height: videoController.value.size.height,
                        child: Chewie(controller: chewieController))),
              ),
            )
          : !widget.isNetwork
              ? Image.asset(
                  widget.thumbnail,
                  fit: BoxFit.cover,
                  width: context.logicalWidth,
                  height: context.logicalHeight,
                )
              : Image.network(
                  widget.thumbnail,
                  fit: BoxFit.cover,
                  width: context.logicalWidth,
                  height: context.logicalHeight,
                ),
    );
  }
}
