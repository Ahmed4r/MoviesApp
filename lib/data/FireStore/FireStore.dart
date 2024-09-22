import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class Firestore {
  static Future<void> removeAllMovies() async {
    // Reference to Firestore collection 'FavMovie'
    CollectionReference movies =
        FirebaseFirestore.instance.collection('FavMovie');

    try {
      // Get all documents in the 'FavMovie' collection
      QuerySnapshot querySnapshot = await movies.get();

      // Loop through each document and delete it
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
      }

      print('All movies deleted successfully');
    } catch (e) {
      print('Failed to delete all movies: $e');
    }
  }

  static Future<void> removeMovieByTitle(String title) async {
    // Reference to Firestore collection 'FavMovie'
    CollectionReference movies =
        FirebaseFirestore.instance.collection('FavMovie');

    try {
      // Query the 'FavMovie' collection for documents where the 'title' matches
      QuerySnapshot querySnapshot =
          await movies.where('title', isEqualTo: title).get();

      // Loop through the documents and delete each one
      for (QueryDocumentSnapshot doc in querySnapshot.docs) {
        await doc.reference.delete();
        print('Movie with title "$title" deleted successfully');
      }

      if (querySnapshot.docs.isEmpty) {
        print('No movie found with the title "$title"');
      }
    } catch (e) {
      print('Failed to remove movie: $e');
    }
  }

  static Future<void> addMovieToFirestore(BuildContext context, String title,
      String imagePath, String description) async {
    // Reference to Firestore collection 'FavMovie'
    CollectionReference movies =
        FirebaseFirestore.instance.collection('FavMovie');

    // Data to be added
    Map<String, dynamic> movieData = {
      'title': title,
      'imagePath': imagePath,
      'description': description,
      'timestamp': FieldValue
          .serverTimestamp(), // Optional: to track when the movie was added
    };

    try {
      // Add movie details to Firestore
      await movies.add(movieData);
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Movie added to Firestore'),
        action: SnackBarAction(label: "close", onPressed: () {}),
      ));

      print('Movie added to Firestore');
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        duration: Duration(seconds: 3),
        content: Text('Failed to add movie: $e'),
        action: SnackBarAction(label: "close", onPressed: () {}),
      ));
      print('Failed to add movie: $e');
    }
  }

  static Future<bool> isMovieInWatchlist(String title) async {
    try {
      // Log the title being searched
      print('Checking for movie with title: $title');

      // Query Firestore to find a movie by title
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('FavMovie')
          .where('title', isEqualTo: title) // Search by title (case-sensitive)
          .limit(1) // Limit to 1 result for efficiency
          .get();

      // Log the result for debugging
      print('Documents found: ${querySnapshot.docs.length}');
      print(querySnapshot.docs.isNotEmpty);
      // If the query returns documents, the movie is in the watchlist
      return querySnapshot.docs.isNotEmpty;
    } catch (e) {
      // Log any errors that occur
      print('Error occurred while checking for movie: $e');
      return false; // Return false in case of an error
    }
  }

  static Future<List<Map<String, dynamic>>> getFavMovies() async {
    // Reference to Firestore collection 'FavMovie'
    CollectionReference movies =
        FirebaseFirestore.instance.collection('FavMovie');

    try {
      // Get all documents from the 'FavMovie' collection
      QuerySnapshot querySnapshot = await movies.get();

      // Map each document to a list of movie data
      List<Map<String, dynamic>> favMovies = querySnapshot.docs.map((doc) {
        return {
          'id': doc.id,
          'title': doc['title'],
          'imagePath': doc['imagePath'],
          'description': doc['description'],
        };
      }).toList();

      return favMovies;
    } catch (e) {
      print('Failed to get movies: $e');
      return [];
    }
  }
}
