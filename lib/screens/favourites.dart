import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:flutter_youtube/flutter_youtube.dart';
import 'package:youtube_favourites/api.dart';
import 'package:youtube_favourites/bloc/favourites_bloc.dart';
import 'package:youtube_favourites/models/video.dart';

class Favourites extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final favBloc = BlocProvider.of<FavouritesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Favourites'),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      backgroundColor: Colors.black12,
      body: StreamBuilder<Map<String, Video>>(
          stream: favBloc.favStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) return Text('hakuna matata');

            return ListView(
                children: snapshot.data.values.map((video) {
              return InkWell(
                  onTap: () {
                    FlutterYoutube.playYoutubeVideoById(
                        apiKey: API_KEY, videoId: video.id);
                  },
                  onLongPress: () => favBloc.toggleFavourite(video),
                  child: Row(children: <Widget>[
                    Container(
                      height: 50,
                      width: 100,
                      child: Image.network(video.thumb),
                      margin: EdgeInsets.symmetric(vertical: 4),
                    ),
                    Expanded(
                      child: Text(
                        video.title,
                        maxLines: 2,
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    )
                  ]));
            }).toList());
          }),
    );
  }
}
