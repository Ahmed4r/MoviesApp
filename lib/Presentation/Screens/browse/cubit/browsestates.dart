import 'package:movies_app/Presentation/Screens/browse/cubit/DiscoverStates.dart';
import 'package:movies_app/model/Browse/MovieDiscoverResponse.dart';

class MovieListLoadingState extends BrowseStates {}

class MovieListSuccessState extends BrowseStates {
  var movieResponse;

  MovieListSuccessState(this.movieResponse);
}

class MovieListErrorState extends BrowseStates {
  final String errorMessage;

  MovieListErrorState(this.errorMessage);
}
