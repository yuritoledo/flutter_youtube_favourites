import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_favourites/models/video.dart';

class FavouritesBloc implements BlocBase {
  Map<String, Video> _favourites = {};

  final _favouriteController = StreamController<Map<String, Video>>.broadcast();

  get favStream => _favouriteController.stream;

  void toggleFavourite(Video video) {
    if (_favourites.containsKey(video.id)) {
      _favourites.remove(video.id);
    } else {
      _favourites[video.id] = video;
    }

    _favouriteController.sink.add(_favourites);
  }

  @override
  void dispose() {
    _favouriteController.close();
  }
}
