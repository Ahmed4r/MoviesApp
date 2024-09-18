import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/cubit/hometabStates.dart';
import 'package:movies_app/data/api/Api_manger.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';

class Hometabviewmodel extends Cubit<HomeTabstates> {
  Hometabviewmodel() : super(HomeTabInitalState());
  List<Movie> movies = [];
  void showMovies() async {
    try {
      emit(HomeTabLoadingState());

      // Call the API only once and store the result
      var response = await ApiManager.getAllTopSide();
      print(response);
      

      // Check if the response is valid and has results
      movies = response.results ?? [];

      // Emit success state with the response data
      emit(HometabSuccessStates(response: response));

      print('Movies loaded successfully');
    } catch (e) {
      // Emit error state with the exception message
      emit(HometabErrostates(errorMessage: e.toString()));
      print('Error fetching movies: $e');
    }
  }
}
