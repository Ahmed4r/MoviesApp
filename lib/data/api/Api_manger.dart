import 'dart:convert';

import 'package:flutter/material.dart';

import 'package:http/http.dart' as http;
import 'package:movies_app/data/api/MovieDetailsApi/movie_details_response.dart';
import 'package:movies_app/data/api/endpoints.dart';

class ApiManger {
  static const String baseUrl = 'api.themoviedb.org';
  //Home Screen Api :

  //home details Api:

  static Future<MovieDetailsResponse> getMovie(String movieID) async {

  var headers = {
    'accept': 'application/json',
    'Authorization': 'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlN2MzOGFjMmFkNDZlMTNjZWRkZmJkODY4MWVmMDljNiIsIm5iZiI6MTcyNjU4MzMwMi4zMzU0NDEsInN1YiI6IjY2ZTk5MDEyMWJlY2E4Y2UwN2QyZTliYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yfWSVG40lcpxu1MYOZOUEwY_15NdwS7JvIfDrFsEMhs'
  };
    try {
      Uri url = Uri.https(baseUrl, "${Endpoints.Movie_Details}/${movieID}");
      var response = await http.get(url,headers: headers);
      return MovieDetailsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }
}
