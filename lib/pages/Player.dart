import 'package:flutter/material.dart';
import 'package:flutter_fer/pages/Song.dart';
import 'package:just_audio/just_audio.dart';

class PlayerScreen extends StatefulWidget {
  Song song;
  Function changeTrack;
  final GlobalKey<PlayerScreenState> key;

  PlayerScreen({this.song, this.changeTrack, this.key}) : super(key: key);

  @override
  PlayerScreenState createState() => PlayerScreenState();
}

class PlayerScreenState extends State<PlayerScreen> {
  double minimumValue = 0.0;
  double maximumValue = 0.0;
  double currentValue = 0.0;
  String currentTime = '';
  String endTime = '';
  bool isPlaying = false;
  Color _iconColor = Color.fromARGB(255, 165, 162, 162);
  final AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    setSong(widget.song);
  }

  void dispose() {
    super.dispose();
    player?.dispose();
  }

  String getDuration(double value) {
    Duration duration = Duration(milliseconds: value.round());

    return [duration.inMinutes, duration.inSeconds]
        .map((element) => element.remainder(60).toString().padLeft(2, '0'))
        .join(':');
  }

  void setSong(Song song) async {
    widget.song = song;
    await player.setUrl(widget.song.songurl);
    currentValue = minimumValue;
    maximumValue = player.duration.inMilliseconds.toDouble();
    setState(() {
      currentTime = getDuration(currentValue);
      endTime = getDuration(maximumValue);

      // Running status change
      isPlaying = false;
      changeStatus();

      player.positionStream.listen((duration) {
        currentValue = duration.inMilliseconds.toDouble();
        if (currentValue >= maximumValue) {
          widget.changeTrack(true);
        }
        setState(() {
          currentTime = getDuration(currentValue);
        });
      });
    });
  }

  void changeStatus() {
    setState(() {
      isPlaying = !isPlaying;
    });

    if (isPlaying) {
      player.play();
    } else {
      player.pause();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    Color musicplayer_theme = Color(0xff264e8b);
    Color custom_grey = Color.fromARGB(255, 165, 162, 162);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: screen_width,
            height: screen_height,
            child: Column(
              children: [
                Container(
                    padding: EdgeInsets.fromLTRB(0.0, 15.0, 0.0, 0.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon: Icon(Icons.arrow_back_ios_new),
                          iconSize: 32.0,
                          color: Color.fromARGB(255, 136, 128, 128),
                        ),
                        Text(
                          "Player",
                          style: TextStyle(
                              fontSize: 22.0,
                              fontFamily: "Varela",
                              color: Color.fromARGB(255, 129, 126, 126),
                              fontWeight: FontWeight.w700),
                        ),
                        IconButton(
                          onPressed: () {},
                          icon: Icon(Icons.more_vert),
                          iconSize: 32.0,
                          color: Color.fromARGB(255, 136, 128, 128),
                        ),
                      ],
                    )),
                Padding(
                  padding: const EdgeInsets.fromLTRB(0.0, 2.0, 0.0, 0.0),
                  child: Card(
                    elevation: 15,
                    shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(65.0))),
                    child: Column(children: [
                      Icon(
                        Icons.horizontal_rule_rounded,
                        size: 50.0,
                        color: Color.fromARGB(255, 165, 162, 162),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Container(
                                padding:
                                    EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 10.0),
                                child: Text("Listening to",
                                    style: TextStyle(
                                        fontWeight: FontWeight.w700,
                                        color: Colors.black,
                                        fontFamily: "Varela",
                                        fontSize: 28)),
                              ),
                            ],
                          )
                        ],
                      ),
                      SizedBox(height: 10),
                      Container(
                        width: screen_width / 100 * 85,
                        height: screen_height / 100 * 40,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(55),
                          child: SizedBox.fromSize(
                            size: Size.fromRadius(
                                180), // Image radius fit: BoxFit.cover
                            child: Image(
                                image: widget.song.imageurl == null
                                    ? AssetImage('assets/music_image.jpg')
                                    : NetworkImage(widget.song.imageurl),
                                fit: BoxFit.cover),
                          ),
                        ),
                      ),
                      SizedBox(height: 5.0),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(0.0, 14.0, 20.0, 0.0),
                        child: Container(
                            height: 60,
                            child: Row(
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(
                                      25.0, 8.0, 15.0, 0.0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.song.songTitle,
                                        style: TextStyle(
                                            fontFamily: 'Varela',
                                            fontWeight: FontWeight.w700,
                                            color: Color.fromARGB(255, 0, 0, 0),
                                            fontSize: 18),
                                      ),
                                      SizedBox(height: 10),
                                      Text(widget.song.artist,
                                          style: TextStyle(
                                              fontFamily: 'Varela',
                                              fontWeight: FontWeight.w700,
                                              fontSize: 13,
                                              color: Color.fromARGB(
                                                  255, 165, 162, 162)))
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: IconButton(
                                    onPressed: () {
                                      setState(() {
                                        _iconColor = musicplayer_theme;
                                      });
                                    },
                                    icon: Icon(Icons.favorite_border_outlined,
                                        color: _iconColor),
                                    iconSize: 35.0,
                                    color: Color.fromARGB(255, 165, 162, 162),
                                    alignment: Alignment.centerRight,
                                  ),
                                ),
                              ],
                            )),
                      ),
                      Slider(
                        min: minimumValue,
                        max: maximumValue + 1,
                        value: currentValue,
                        onChanged: (double value) {
                          currentValue = value;
                          player.seek(
                            Duration(
                              milliseconds: currentValue.round(),
                            ),
                          );
                        },
                        activeColor: musicplayer_theme,
                        inactiveColor: Color.fromARGB(255, 192, 191, 191),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(25.0, 10.0, 15.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(currentTime,
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 165, 162, 162))),
                            Text(endTime,
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 13,
                                    color: Color.fromARGB(255, 165, 162, 162)))
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.fromLTRB(12.0, 20.0, 15.0, 0.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconButton(
                              onPressed: () {},
                              icon: Icon(Icons.shuffle),
                              iconSize: 30.0,
                              color: custom_grey,
                            ),
                            IconButton(
                                onPressed: () {
                                  widget.changeTrack(false);
                                },
                                icon: Icon(Icons.skip_previous),
                                iconSize: 35.0,
                                color: custom_grey),
                            GestureDetector(
                              child: Icon(
                                  isPlaying
                                      ? Icons.pause_circle
                                      : Icons.play_circle,
                                  color: musicplayer_theme,
                                  size: 60),
                              behavior: HitTestBehavior.translucent,
                              onTap: () {
                                changeStatus();
                              },
                            ),
                            IconButton(
                                onPressed: () {
                                  widget.changeTrack(true);
                                },
                                icon: Icon(Icons.skip_next),
                                iconSize: 35.0,
                                color: custom_grey),
                            IconButton(
                              onPressed: () {
                                Navigator.pop(context);
                              },
                              icon: Icon(Icons.queue_music),
                              iconSize: 30.0,
                              color: custom_grey,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 90,
                      )
                    ]),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
