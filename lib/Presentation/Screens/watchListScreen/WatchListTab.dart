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
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Firestore.getFavMovies(), // Call the getFavMovies function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(child: Text('No favorite movies found'));
          }

          // Data is available
          final favMovies = snapshot.data!;
          return ListView.builder(
            itemCount: favMovies.length,
            itemBuilder: (context, index) {
              final movie = favMovies[index];
              return Card(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: ListTile(
                  leading: Image.network(
                    movie['imagePath'] ?? '',
                    width: 50,
                    height: 75,
                    fit: BoxFit.cover,
                  ),
                  title: Text(movie['title'] ?? 'Unknown'),
                  subtitle: Text(movie['description'] ?? 'No description available'),
                  onTap: () {
                    // Handle movie tap (e.g., navigate to details page)
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}
