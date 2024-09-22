import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:movies_app/data/FireStore/FireStore.dart';

class WatchListTab extends StatelessWidget {
    static const String routename = 'watchlisttab';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorite Movies'),
      ),
      body: StreamBuilder<List<Map<String, dynamic>>>(
        stream: Firestore.getFavMoviesStream(), // Stream that listens for changes
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite movies found'));
          }

          // Get the list of movies
          List<Map<String, dynamic>> movies = snapshot.data!;

          return ListView.builder(
            itemCount: movies.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.network(movies[index]['imagePath'], width: 50, height: 50, fit: BoxFit.cover),
                title: Text(movies[index]['title']),
                subtitle: Text(movies[index]['description']),
              );
            },
          );
        },
      ),
    );
  }
}
