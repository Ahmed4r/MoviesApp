import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:movies_app/data/api/endpoints.dart';
import 'package:movies_app/model/hometabmodel/NewRealeases.dart';
import 'package:movies_app/model/hometabmodel/RecommendedResponse.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';

import '../../model/Browse/CategoryNamesResponse.dart';

class ApiManager {
  static const String baseUrl = "api.themoviedb.org";
  static const String apiKey = "1e6afa8fe1adde6391e294c8b8f4a310";

  static Future<List<Movie>> getAllTopSide() async {
    try {
      Uri url = Uri.https(baseUrl, '3/movie/popular', {
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
        return decodedData.map((movie) => Movie.fromJson(movie)).toList();
      } else {
        throw Exception(
            "Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }

  static Future<List<Results>> getNewRealeases() async {
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
        print(decodedData);
        return decodedData.map((newr) => Results.fromJson(newr)).toList();
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
        print(decodedData);
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

  static Future<List<Genres>> getCategoryNames() async {
    try {
      Uri url = Uri.https(baseUrl, Endpoints.BrowseCategory, {
        'language': 'en-US',
        'page': '1',
        'api_key': apiKey,
      });

      final response = await http.get(url, headers: {
        'Accept': 'application/json',
      });

      if (response.statusCode == 200) {
        final decodedData = json.decode(response.body);
        final genresList = decodedData['genres'] as List;
        return genresList.map((genre) => Genres.fromJson(genre)).toList();
      } else {
        throw Exception(
            "Failed to load data. Status code: ${response.statusCode}");
      }
    } catch (e) {
      throw Exception("Error fetching data: $e");
    }
  }
}
