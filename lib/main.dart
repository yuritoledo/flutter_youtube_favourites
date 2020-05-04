import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favourites/bloc/videos_bloc.dart';
import 'package:youtube_favourites/screens/home.dart';

main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Youutube',
      home: BlocProvider<VideosBloc>(
        child: Home(),
        bloc: VideosBloc(),
      ),
    );
  }
}
