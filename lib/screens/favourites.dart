import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
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
        backgroundColor: Colors.black87,
      ),
      backgroundColor: Colors.grey,
      body: StreamBuilder<Map<String, Video>>(
          stream: favBloc.favStream,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Text('hakuna matata');
            }

            return ListView(
                children: snapshot.data.values.map((item) {
              return InkWell(
                  child: Row(children: <Widget>[
                Container(
                  height: 50,
                  width: 100,
                  child: Image.network(item.thumb),
                  margin: EdgeInsets.symmetric(vertical: 4),
                ),
                Expanded(
                  child: Text(
                    item.title,
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
