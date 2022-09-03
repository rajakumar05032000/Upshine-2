import 'package:flutter/material.dart';

class song_list_view extends StatefulWidget {
  final String image_url, song_name, Song_info;

  const song_list_view(this.image_url, this.song_name, this.Song_info);

  @override
  _song_list_viewState createState() => _song_list_viewState();
}

class _song_list_viewState extends State<song_list_view> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(0.0, 16.0, 10.0, 0.0),
      child: Container(
          height: 70,
          child: Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: SizedBox.fromSize(
                  size: Size.fromRadius(35), // Image radius
                  child: Image.network(widget.image_url, fit: BoxFit.cover),
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(25.0, 8.0, 15.0, 0.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.song_name,
                      style: TextStyle(
                          fontFamily: 'Varela',
                          fontWeight: FontWeight.w700,
                          color: Color.fromARGB(255, 0, 0, 0),
                          fontSize: 15),
                    ),
                    SizedBox(height: 10),
                    Text(widget.Song_info,
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontWeight: FontWeight.w700,
                            fontSize: 12,
                            color: Color.fromARGB(255, 165, 162, 162)))
                  ],
                ),
              ),
              Expanded(
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.more_vert),
                  iconSize: 35.0,
                  color: Color.fromARGB(255, 165, 162, 162),
                  alignment: Alignment.centerRight,
                ),
              ),
            ],
          )),
    );
  }
}
