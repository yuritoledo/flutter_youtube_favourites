import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favourites/bloc/favourites_bloc.dart';
import 'package:youtube_favourites/bloc/videos_bloc.dart';
import 'package:youtube_favourites/delegates/data_search.dart';
import 'package:youtube_favourites/models/video.dart';
import 'package:youtube_favourites/widgets/video_tile.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final videosBloc = BlocProvider.of<VideosBloc>(context);
    final favBloc = BlocProvider.of<FavouritesBloc>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Youuutube'),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          StreamBuilder<Map<String, Video>>(
              initialData: {},
              stream: favBloc.favStream,
              builder: (context, snapshot) {
                return Align(
                  child: Text(snapshot.data?.length.toString() ?? 0),
                );
              }),
          IconButton(icon: Icon(Icons.star), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final search =
                    await showSearch(context: context, delegate: DataSearch());

                if (search != null) {
                  videosBloc.inSearch.add(search);
                }
              }),
        ],
      ),
      body: StreamBuilder(
        initialData: [],
        stream: videosBloc.outVideos,
        builder: (context, snapshot) {
          if (!snapshot.hasData) return Container();

          return ListView.builder(
            itemCount: snapshot.data.length + 1,
            itemBuilder: (context, index) {
              if (index < snapshot.data.length) {
                return VideoTile(snapshot.data[index]);
              } else if (index > 1) {
                videosBloc.inSearch.add(null);
                return Loader();
              } else {
                return Container();
              }
            },
          );
        },
      ),
    );
  }
}

class Loader extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.red),
      ),
      height: 40,
      width: 40,
      alignment: Alignment.center,
    );
  }
}
