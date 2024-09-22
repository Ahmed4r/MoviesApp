import 'package:flutter/material.dart';
import 'package:movies_app/data/FireStore/FireStore.dart';

class Providerr extends ChangeNotifier {
  List<Map<String, dynamic>> favMovie = [];

  void GetFavMovies() async {
    favMovie = await Firestore.getFavMovies();
    notifyListeners();
  }
}
