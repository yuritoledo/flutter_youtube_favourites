import 'dart:async';

import 'package:bloc_pattern/bloc_pattern.dart';
import 'package:youtube_favourites/api.dart';
import 'package:youtube_favourites/models/video.dart';

class VideosBloc implements BlocBase {
  Api api;
  List<Video> videos;

  final _videosController = StreamController<List<Video>>();
  final _searchController = StreamController<String>();

  Sink get inSearch => _searchController.sink;
  Stream get outVideos => _videosController.stream;

  VideosBloc() {
    api = Api();

    _searchController.stream.listen(_search);
  }

  void _search(search) async {
    if (search != null) {
      videos = await api.search(search);
    } else {
      videos += await api.nextPage();
    }

    _videosController.sink.add(videos);
  }

  @override
  void dispose() {
    _videosController.close();
    _searchController.close();
  }
}
