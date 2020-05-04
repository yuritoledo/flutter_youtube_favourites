import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favourites/bloc/videos_bloc.dart';
import 'package:youtube_favourites/delegates/data_search.dart';

class Home extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Youuutube'),
        backgroundColor: Colors.black87,
        actions: <Widget>[
          Align(
            child: Text('0'),
          ),
          IconButton(icon: Icon(Icons.star), onPressed: () {}),
          IconButton(
              icon: Icon(Icons.search),
              onPressed: () async {
                final search =
                    await showSearch(context: context, delegate: DataSearch());

                if (search != null) {
                  BlocProvider.of<VideosBloc>(context).inSearch.add(search);
                }
              }),
        ],
      ),
    );
  }
}
