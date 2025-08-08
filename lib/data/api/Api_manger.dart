import 'dart:convert';
import 'package:http/http.dart' as http;

import 'package:movies_app/data/api/MovieDetailsApi/movie_details_response.dart';
import 'package:movies_app/data/api/endpoints.dart';
import 'package:movies_app/model/Browse/CategoryNameResponse.dart';
import 'package:movies_app/model/Browse/movieDiscoverResponse.dart';

import 'package:movies_app/model/hometabmodel/NewRealeases.dart';
import 'package:movies_app/model/hometabmodel/RecommendedResponse.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';
import 'package:movies_app/model/searchmodel/searchResponse.dart';

class ApiManager {
  static const String baseUrl = "api.themoviedb.org";
  static const String apiKey = "3d959f317b9ce9d57f24b5cf8220dda6";

  static Future<HometabResponse> getAllTopSide() async {
    try {
      Uri url = Uri.https(baseUrl, Endpoints.top_side_section, {
        'language': 'en-US',
        'page': '1',
        'api_key': apiKey,
      });
      var response = await http.get(url, headers: {
        'Accept': 'application/json',
      });
      return HometabResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }

  static Future<List<Response>> getNewRealeases() async {
    try {
      Uri url = Uri.https(baseUrl, Endpoints.New_Realeases, {
        'language': 'en-US',
        'page': '1',
        'api_key': apiKey,
      });

      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        // return HometabResponse.fromJson(jsonDecode(response.body)['results'] as List  );
        final decodedData = json.decode(response.body)['results'] as List;
        // print(decodedData);
        return decodedData.map((newr) => Response.fromJson(newr)).toList();
      } else {
        throw Exception(
            "Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  static Future<List<RecommdedData>> getRecommended() async {
    try {
      Uri url = Uri.https(baseUrl, Endpoints.Recommended, {
        'language': 'en-US',
        'page': '1',
        'api_key': apiKey,
      });

      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        // return HometabResponse.fromJson(jsonDecode(response.body)['results'] as List  );
        final decodedData = json.decode(response.body)['results'] as List;
        // print(decodedData);
        return decodedData
            .map((recdata) => RecommdedData.fromJson(recdata))
            .toList();
      } else {
        throw Exception(
            "Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  static Future<CategoryNameResponse> getCategoryNames() async {
    try {
      Uri url = Uri.https(baseUrl, Endpoints.BrowseCategory, {
        'language': 'en-US',
        'page': '1',
        'api_key': apiKey,
      });

      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      return CategoryNameResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  static Future<MovieDetailsResponse> getMovie(String movieID) async {
    var headers = {
      'accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlN2MzOGFjMmFkNDZlMTNjZWRkZmJkODY4MWVmMDljNiIsIm5iZiI6MTcyNjU4MzMwMi4zMzU0NDEsInN1YiI6IjY2ZTk5MDEyMWJlY2E4Y2UwN2QyZTliYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yfWSVG40lcpxu1MYOZOUEwY_15NdwS7JvIfDrFsEMhs'
    };
    try {
      Uri url = Uri.https(baseUrl, "${Endpoints.Movie_Details}/${movieID}");
      var response = await http.get(url, headers: headers);
      return MovieDetailsResponse.fromJson(jsonDecode(response.body));
    } catch (e) {
      throw e;
    }
  }

  // browes Api :
  static Future<MovieDiscoverResponse> getMoviesByGenre(int genreId) async {
    try {
      Uri url = Uri.https(baseUrl, Endpoints.Discover_Movies, {
        'api_key': apiKey,
        'with_genres': genreId.toString(),
        'language': 'en-US',
        'page': '1',
      });

      final response = await http.get(url);

      if (response.statusCode == 200) {
        return MovieDiscoverResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Failed to load movies");
      }
    } catch (e) {
      throw Exception("Error fetching movies: $e");
    }
  }

  //search
  static Future<SearchResponse> searchMovie(String Search) async {
    var headers = {
      'accept': 'application/json',
      'Authorization':
          'Bearer eyJhbGciOiJIUzI1NiJ9.eyJhdWQiOiJlN2MzOGFjMmFkNDZlMTNjZWRkZmJkODY4MWVmMDljNiIsIm5iZiI6MTcyNjU4MzMwMi4zMzU0NDEsInN1YiI6IjY2ZTk5MDEyMWJlY2E4Y2UwN2QyZTliYyIsInNjb3BlcyI6WyJhcGlfcmVhZCJdLCJ2ZXJzaW9uIjoxfQ.yfWSVG40lcpxu1MYOZOUEwY_15NdwS7JvIfDrFsEMhs'
    };
    try {
      Uri url = Uri.https(
          baseUrl, "${Endpoints.search_for_move_name}", {'query': Search});

      var response = await http.get(url, headers: headers);
      if (response.statusCode == 200 && response.statusCode < 300) {
        return SearchResponse.fromJson(jsonDecode(response.body));
      } else {
        throw Exception('Failed to load movie details: ${response.statusCode}');
      }
    } catch (e) {
      throw e;
    }
  }
}
