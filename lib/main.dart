import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:flutter/material.dart';
import 'package:youtube_favourites/bloc/favourites_bloc.dart';
import 'package:youtube_favourites/bloc/videos_bloc.dart';
import 'package:youtube_favourites/screens/home.dart';

main(List<String> args) {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<VideosBloc>(
      bloc: VideosBloc(),
      child: BlocProvider<FavouritesBloc>(
        bloc: FavouritesBloc(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Youutube',
          home: Home(),
        ),
      ),
    );
  }
}
