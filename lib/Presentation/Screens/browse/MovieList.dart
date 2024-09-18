import 'package:flutter/material.dart';

class MovieList extends StatelessWidget {
  static const String routename = 'movieList';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text('Movie List'),
      ),
      body: Container(
        color: Colors.black,
      ),
    );
  }
}
