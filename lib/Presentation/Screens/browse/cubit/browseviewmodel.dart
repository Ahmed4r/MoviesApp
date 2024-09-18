
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/browsestates.dart';
import 'package:movies_app/data/api/Api_manger.dart';
import 'package:movies_app/data/api/MovieDetailsApi/movie_details_response.dart';

class Browseviewmodel extends Cubit<Browsestates> {
  Browseviewmodel() : super(BrowseInitialStates());

  List<Genres> categoryNames = []; // Initialize as an empty list

  void getBrowseNames() async {
    try {
      emit(BrowseLoadingStates());
      var response = await ApiManager.getCategoryNames();
 
      // categoryNames = response.genres??[]; 
      emit(BrowseSuccessStates(response: response));
    } catch (e) {
      emit(
          BrowseErrorStates(errorMessage: e.toString())); 
    }
  }
}
