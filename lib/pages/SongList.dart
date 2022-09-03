import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_fer/custom_widgets/heading_text.dart';
import 'package:flutter_fer/custom_widgets/song_list_view.dart';
import 'package:flutter_fer/custom_widgets/topbar_center_text.dart';
// import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:flutter_fer/pages/Player.dart';
import 'package:flutter_fer/pages/Song.dart';

class SongList extends StatefulWidget {
  String prediction;
  SongList({this.prediction});

  @override
  _SongListState createState() => _SongListState();
}

class _SongListState extends State<SongList> {
  // List of songs
  // final FlutterAudioQuery audioQuery = FlutterAudioQuery();

  List<Song> songs = [];
  List music = [];
  int currentIndex = 0;

  final GlobalKey<PlayerScreenState> key = GlobalKey<PlayerScreenState>();

  void initState() {
    super.initState();
    getFirebaseData();
  }

  // Connect and get data from firebase
  void getFirebaseData() async {
    String predictedResult =
        "${widget.prediction[0].toUpperCase()}${widget.prediction.substring(1)}";

    Query musicList = FirebaseFirestore.instance
        .collection('MUSIC')
        .where('type', isEqualTo: predictedResult);

    QuerySnapshot snapshots = await musicList.get();

    for (DocumentSnapshot snapshot in snapshots.docs) {
      // Adding data in songs list
      songs.add(Song(
          songTitle: snapshot.data()['song'],
          artist: snapshot.data()['artist'],
          type: snapshot.data()['type'],
          imageurl: snapshot.data()['imageurl'],
          songurl: snapshot.data()['songurl']));

      setState(() {
        songs = songs;
      });
    }
  }

  void changeTrack(bool isNext) {
    if (isNext) {
      if (currentIndex != songs.length - 1) {
        currentIndex++;
      }
    } else {
      if (currentIndex != 0) {
        currentIndex--;
      }
    }

    key.currentState.setSong(songs[currentIndex]);
  }

  @override
  Widget build(BuildContext context) {
    Color musicplayer_theme = Color(0xff264e8b);
    double screen_width = MediaQuery.of(context).size.width;
    double screen_height = MediaQuery.of(context).size.height;
    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
                padding: EdgeInsets.fromLTRB(0.0, 10.0, 0.0, 0.0),
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
                    topbar_center_text("Musics"),
                    IconButton(
                      onPressed: () {},
                      icon: Icon(Icons.more_vert),
                      iconSize: 32.0,
                      color: Color.fromARGB(255, 136, 128, 128),
                    ),
                  ],
                )),
            SizedBox(
              height: 3.0,
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
                child: Column(
                  children: [
                    headingtext("Music list"),
                    Container(
                      padding: EdgeInsets.fromLTRB(5.0, 15.0, 15.0, 0.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text("Songs",
                              style: TextStyle(
                                color: musicplayer_theme,
                                fontWeight: FontWeight.w700,
                                fontFamily: "Varela",
                                fontSize: 17,
                              )),
                          Text("Artists",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 165, 162, 162),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Varela",
                                  fontSize: 17)),
                          Text("Album",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 165, 162, 162),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Varela",
                                  fontSize: 17)),
                          Text("Playlist",
                              style: TextStyle(
                                  color: Color.fromARGB(255, 165, 162, 162),
                                  fontWeight: FontWeight.w700,
                                  fontFamily: "Varela",
                                  fontSize: 17)),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 15.0,
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.fromLTRB(15.0, 5.0, 15.0, 5.0),
              child: SizedBox(
                height: screen_height,
                child: ListView.builder(
                    itemCount: songs.length,
                    itemBuilder: (context, index) {
                      var current_song = songs[index];
                      var title1 = current_song.songTitle;

                      if (title1.length >= 20) {
                        title1 = title1.substring(0, 20);
                      }

                      var artist1 = current_song.artist;
                      if (artist1.length >= 20) {
                        artist1 = artist1.substring(0, 20);
                      }
                      print(current_song.imageurl);

                      return GestureDetector(
                        onTap: () {
                          currentIndex = index;
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => PlayerScreen(
                                changeTrack: changeTrack,
                                song: songs[index],
                                key: key,
                              ),
                            ),
                          );
                        },
                        child: song_list_view(
                            current_song.imageurl, title1, artist1),
                      );
                    }),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
