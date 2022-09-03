import 'package:flutter/material.dart';


class music_card extends StatefulWidget {
  final String image_url, song_name, Song_info;

  const music_card(this.image_url, this.song_name, this.Song_info);

  @override
  _music_cardState createState() => _music_cardState();
}

class _music_cardState extends State<music_card> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      height: 160,
      child: Card(
        elevation: 5,
        shape:
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(20.0)),
        child: Stack(
          children: [
            Container(
              width: 160,
              height: 160,
              alignment: Alignment.center,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(180), // Image radius
                  child: Image.network(widget.image_url, fit: BoxFit.cover),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(9.0, 104.0, 4.0, 15.0),
              child: Container(
                height: 50,
                width: 160,
                child: Card(
                    elevation: 1,
                    color: Colors.transparent,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12.0)),
                    child: Row(
                      children: [
                        Container(
                          padding: EdgeInsets.fromLTRB(6.0, 0.0, 0.0, 0.0),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                widget.song_name,
                                style: TextStyle(
                                    fontFamily: 'Varela',
                                    fontWeight: FontWeight.w700,
                                    color: Color.fromARGB(255, 255, 255, 255)),
                              ),
                              Text(widget.Song_info,
                                  style: TextStyle(
                                      fontFamily: 'Varela',
                                      fontWeight: FontWeight.w700,
                                      fontSize: 10,
                                      color:
                                          Color.fromARGB(255, 255, 255, 255)))
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            IconButton(
                              alignment: Alignment.centerRight,
                              iconSize: 34.0,
                              onPressed: () {
                                Navigator.pushNamed(context, "/player");
                              },
                              icon: Icon(Icons.play_circle),
                              color: Colors.white,
                            )
                          ],
                        )
                      ],
                    )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
