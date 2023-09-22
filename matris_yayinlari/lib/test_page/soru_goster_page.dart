import 'package:flutter/material.dart';
import 'package:matris_yayinlari/context_mediaquery.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class SoruDetaySayfasi extends StatefulWidget {
  final dynamic soru;
  final List<dynamic> sorular;
  const SoruDetaySayfasi(
      {super.key, required this.soru, required this.sorular});

  @override
  State<SoruDetaySayfasi> createState() => _SoruDetaySayfasiState();
}

class _SoruDetaySayfasiState extends State<SoruDetaySayfasi> {
  late YoutubePlayerController _controller;
  bool isButtonClickable = true;

  @override
  void initState() {
    final videoID = YoutubePlayer.convertUrlToId(widget.soru['url']);
    _controller = YoutubePlayerController(
        initialVideoId: videoID!,
        flags: const YoutubePlayerFlags(
          autoPlay: true,
        ));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(widget.soru['title']),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: context.dynamicHeight(0.25)),
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
              progressColors: const ProgressBarColors(
                  playedColor: Colors.deepPurple, handleColor: Colors.green),
              onReady: () => debugPrint('Ready'),
            ),
            SizedBox(
              height: context.dynamicHeight(0.25),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Opacity(
                  opacity: (widget.soru['id'] - 1 > 0) ? 1.0 : 0.2,
                  child: ElevatedButton(
                    onPressed: () {
                      if (widget.soru['id'] - 1 > 0) {
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                                builder: (context) => SoruDetaySayfasi(
                                    sorular: const [], soru: widget.soru['id'] - 1)));
                      }
                    },
                    style: ElevatedButton.styleFrom(
                        minimumSize: Size(context.dynamicWidth(0.45),
                            context.dynamicHeight(0.05))),
                    child: widget.soru['id'] - 1 > 0
                        ? Text(
                            '${widget.soru['id'] - 1}. Soru',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white70,
                            ),
                          )
                        : const Text('Önceki Soru'),
                  ),
                ),
                Opacity(
                  opacity:
                      widget.soru['id'] + 1 < widget.sorular.length ? 1.0 : 0.2,
                  child: ElevatedButton(
                      onPressed: () {
                        if (widget.soru['id'] + 1 < widget.sorular.length) {
                          Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => SoruDetaySayfasi(
                                      sorular: const[],
                                      soru: widget.soru['id'] + 1)));
                        }
                      },
                      style: ElevatedButton.styleFrom(
                          minimumSize: Size(context.dynamicWidth(0.45),
                              context.dynamicHeight(0.05))),
                      child: widget.soru['id'] + 1 < widget.sorular.length
                          ? Text(
                              '${widget.soru['id'] + 1}. Soru',
                              style: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.white70,
                              ),
                            )
                          : const Text('Sonraki Soru')),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
