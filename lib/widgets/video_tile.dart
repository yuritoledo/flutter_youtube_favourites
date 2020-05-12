import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favourites/bloc/favourites_bloc.dart';
import 'package:youtube_favourites/models/video.dart';

class VideoTile extends StatelessWidget {
  final Video video;

  VideoTile(this.video);

  @override
  Widget build(BuildContext context) {
    final favBloc = BlocProvider.of<FavouritesBloc>(context);

    return Container(
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 4.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          AspectRatio(
            aspectRatio: 16.0 / 9.0,
            child: Image.network(
              video.thumb,
              fit: BoxFit.cover,
            ),
          ),
          Row(
            children: <Widget>[
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.fromLTRB(8, 8, 8, 0),
                      child: Text(
                        video.channel,
                        style: TextStyle(color: Colors.white, fontSize: 16.0),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8),
                      child: Text(
                        video.title,
                        maxLines: 2,
                        style: TextStyle(color: Colors.white, fontSize: 14.0),
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<Map<String, Video>>(
                  stream: favBloc.favStream,
                  initialData: {},
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) return CircularProgressIndicator();

                    final icon = snapshot.data.containsKey(video.id)
                        ? Icons.star
                        : Icons.star_border;

                    return IconButton(
                      icon: Icon(icon),
                      iconSize: 30.0,
                      onPressed: () => favBloc.toggleFavourite(video),
                      color: Colors.white,
                    );
                  }),
            ],
          ),
        ],
      ),
    );
  }
}
