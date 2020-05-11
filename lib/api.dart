import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_favourites/models/video.dart';

const API_KEY = 'AIzaSyB3TzqYgtNWFhh_FDY8VaxKZcGJK5A3gLM';

class Api {
  String _search;
  String _nextToken;

  Future<List<Video>> search(String search) async {
    _search = search;

    http.Response resp = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");

    return decode(resp);
  }

  Future<List<Video>> nextPage() async {
    http.Response resp = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$_search&type=video&key=$API_KEY&maxResults=10&pageToken=$_nextToken");

    return decode(resp);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      _nextToken = decoded['nextPageToken'];
      List<Video> videos =
          decoded['items'].map<Video>((item) => Video.fromJson(item)).toList();

      return videos;
    }

    throw new Exception('hakuna matata');
  }
}
