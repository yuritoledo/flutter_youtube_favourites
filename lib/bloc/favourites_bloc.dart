import 'dart:async';
import 'dart:convert';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:rxdart/subjects.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:youtube_favourites/models/video.dart';

class FavouritesBloc implements BlocBase {
  Map<String, Video> _favourites = {};

  final _favouriteController =
      BehaviorSubject<Map<String, Video>>(seedValue: {});

  FavouritesBloc() {
    _getPersistedData();
  }

  void _getPersistedData() async {
    final pref = await SharedPreferences.getInstance();
    if (pref.getKeys().contains('favourites')) {
      _favourites = json
          .decode(pref.getString('favourites'))
          .map((k, v) => MapEntry(k, Video.fromJson(v)))
          .cast<String, Video>();
    }
    _favouriteController.sink.add(_favourites);
  }

  get favStream => _favouriteController.stream;

  void toggleFavourite(Video video) {
    if (_favourites.containsKey(video.id)) {
      _favourites.remove(video.id);
    } else {
      _favourites[video.id] = video;
    }

    _favouriteController.sink.add(_favourites);
    _persistData();
  }

  Future<void> _persistData() async {
    final pref = await SharedPreferences.getInstance();
    pref.setString('favourites', json.encode(_favourites));
  }

  @override
  void dispose() {
    _favouriteController.close();
  }
}
