import 'package:billit_now/apps/helper/theme/media_query_extended.dart';
import 'package:billit_now/apps/helper/theme/theme_data_extended.dart';
import 'package:billit_now/apps/helper/utils/app_icon.dart';
import 'package:billit_now/apps/helper/utils/app_icon_name.dart';
import 'package:billit_now/component/read_more_text.dart';
import 'package:billit_now/features/base/base_stateful_widget.dart';
import 'package:billit_now/repositories/event/models/about_artist_model.dart';
import 'package:billit_now/repositories/event/models/top_music.dart';
import 'package:billit_now/templates/events/widgets/app_collapse.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class AboutArtist extends BaseStatefulWidget {
  const AboutArtist({super.key, required this.data});

  final AboutArtistModel data;

  @override
  State<AboutArtist> createState() => _AboutArtist();
}

class _AboutArtist extends BaseWidgetState<AboutArtist> {
  final player1 = AudioPlayer();
  Duration? duration1;
  bool isPlay1 = false;
  bool isReady1 = false;

  final player2 = AudioPlayer();
  Duration? duration2;
  bool isPlay2 = false;
  bool isReady2 = false;

  @override
  void initState() {
    initDurationMusic();
    super.initState();
  }

  @override
  void dispose() {
    player1.dispose();
    player2.dispose();
    super.dispose();
  }

  initDurationMusic() async {
    if (widget.data.musics.isNotEmpty) {
      duration1 = widget.data.musics[0].source.contains('assets')
          ? await player1.setAsset(widget.data.musics[0].source)
          : await player1.setUrl(widget.data.musics[0].source);

      player1.playerStateStream.listen((state) {
        if (state.processingState == ProcessingState.ready) {
          setState(() {
            isReady1 = true;
          });
        }
      });
      if (widget.data.musics.length > 1) {
        duration2 = widget.data.musics[1].source.contains('assets')
            ? await player2.setAsset(widget.data.musics[1].source)
            : await player2.setUrl(widget.data.musics[1].source);

        player2.playerStateStream.listen((state) {
          if (state.processingState == ProcessingState.ready) {
            setState(() {
              isReady2 = true;
            });
          }
        });
      }
    }
  }

  void handlePlayPause(AudioPlayer player) {
    if (player.playing) {
      player.pause();
    } else {
      player.play();
    }
  }

  @override
  Widget body(BuildContext context) {
    return LayoutBuilder(builder: (context, constraint) {
      return Container(
          width: constraint.maxWidth,
          padding: EdgeInsets.only(bottom: 40.0),
          child: AppCollapse(
            title: 'About ${widget.data.artistName}',
            children: [
              ReadMoreText(
                text: widget.data.about.trim(),
                trimLength: 450,
                style: Theme.of(context).appTexts.textMdRegular.copyWith(
                    color: Theme.of(context).appColors.textSecondary700),
                trimTextStyle: Theme.of(context)
                    .appTexts
                    .textMdSemiBold
                    .copyWith(
                        color: Theme.of(context).appColors.buttonTeritoryFg),
              ),
              Padding(
                  padding: EdgeInsets.only(top: 24.0, bottom: 16.0),
                  child: Text(
                      'Enjoy some of ${widget.data.artistName}\'s most beloved tracks',
                      style: Theme.of(context).appTexts.textLgSemiBold.copyWith(
                          color: Theme.of(context).appColors.textPrimary900))),
              Padding(
                padding: EdgeInsets.only(top: 24.0),
                child: context.isSmallTabletOrLess
                    ? Column(
                        children: [
                          widget.data.musics.isEmpty
                              ? Container()
                              : _musicPlayer(
                                  context, widget.data.musics.first, isPlay1,
                                  () {
                                  if (player2.playing) {
                                    player2.stop();
                                  }
                                  handlePlayPause(player1);
                                  setState(() async {
                                    isPlay2 = false;
                                    isPlay1 = !isPlay1;
                                  });
                                }),
                          SizedBox(height: 16.0),
                          widget.data.musics.length > 1
                              ? _musicPlayer(
                                  context, widget.data.musics[1], isPlay2, () {
                                  if (player1.playing) {
                                    player1.stop();
                                  }
                                  handlePlayPause(player2);
                                  setState(() async {
                                    isPlay1 = false;
                                    isPlay2 = !isPlay2;
                                  });
                                })
                              : Container()
                        ],
                      )
                    : Row(
                        children: [
                          widget.data.musics.isEmpty
                              ? Container()
                              : _musicPlayer(
                                  context, widget.data.musics.first, isPlay1,
                                  () {
                                  if (player2.playing) {
                                    player2.stop();
                                  }
                                  handlePlayPause(player1);
                                  setState(() async {
                                    isPlay2 = false;
                                    isPlay1 = !isPlay1;
                                  });
                                }),
                          widget.data.musics.length > 1
                              ? _musicPlayer(
                                  context, widget.data.musics[1], isPlay2, () {
                                  if (player1.playing) {
                                    player1.stop();
                                  }
                                  handlePlayPause(player2);
                                  setState(() async {
                                    isPlay1 = false;
                                    isPlay2 = !isPlay2;
                                  });
                                })
                              : Container()
                        ],
                      ),
              )
            ],
          ));
    });
  }

  _musicPlayer(BuildContext context, TopMusicModel music, bool isPlay, Function() onTap) =>
      SizedBox(
        width: context.logicalWidth / 4,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center, // Align vertically centered
          children: [
            InkWell(
              splashColor: Colors.transparent,
              highlightColor: Colors.transparent,
              hoverColor: Colors.transparent,
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Theme.of(context).appColors.alphaWite20.withOpacity(0.8),
                    width: 1,
                  ),
                  color: Theme.of(context).appColors.fgBrandPrimary600,
                  borderRadius: BorderRadius.circular(100),
                ),
                padding: const EdgeInsets.all(12.0),
                child: AppIcon.button(
                  appIconName: isPlay
                      ? AppIconName.uebe6PauseCircle
                      : AppIconName.uebeaPlay,
                  context: context,
                ),
              ),
            ),
            const SizedBox(width: 12.0),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start, // Align text to the left
                children: [
                  Text(
                    music.name,
                    style: Theme.of(context).appTexts.textMdSemiBold.copyWith(
                      color: Theme.of(context).appColors.textSecondary700,
                    ),
                  ),
                  if (music.album.isNotEmpty) // Only display album if it's not empty
                    Padding(
                      padding: const EdgeInsets.only(top: 4.0), // Add some spacing
                      child: Text(
                        music.album,
                        style: Theme.of(context).appTexts.textSmRegular.copyWith(
                          color: Theme.of(context).appColors.textTeritory600,
                        ),
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      );
}
