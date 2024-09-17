import 'package:movies_app/data/api/MovieDetailsApi/movie_details_response.dart';

abstract class MovieDetailsStates {}

class MovieDetailsInichialStates extends MovieDetailsStates {}

class MovieDetailsLoudingStates extends MovieDetailsStates {}

class MovieDetailsErorrStates extends MovieDetailsStates {
  String erorrMessage;
  MovieDetailsErorrStates({required this.erorrMessage});
}

class MovieDetailsSuccessStates extends MovieDetailsStates {
    MovieDetailsResponse response;
  MovieDetailsSuccessStates({required this.response});
}
