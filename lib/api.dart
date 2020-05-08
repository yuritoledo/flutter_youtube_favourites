import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:youtube_favourites/models/video.dart';

const API_KEY = 'AIzaSyB3TzqYgtNWFhh_FDY8VaxKZcGJK5A3gLM';

class Api {
  search(String search) async {
    http.Response resp = await http.get(
        "https://www.googleapis.com/youtube/v3/search?part=snippet&q=$search&type=video&key=$API_KEY&maxResults=10");

    return decode(resp);
  }

  List<Video> decode(http.Response response) {
    if (response.statusCode == 200) {
      final decoded = json.decode(response.body);
      List<Video> videos =
          decoded['items'].map<Video>((item) => Video.fromJson(item)).toList();

      return videos;
    }

    throw new Exception('hakuna matata');
  }
}
