import 'package:flutter/material.dart';
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
                print(search);
              }),
        ],
      ),
    );
  }
}
