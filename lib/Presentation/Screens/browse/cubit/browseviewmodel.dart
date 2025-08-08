import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/DiscoverStates.dart';
import 'package:movies_app/data/api/Api_manger.dart';
import 'package:movies_app/data/api/MovieDetailsApi/movie_details_response.dart';

class Browseviewmodel extends Cubit<BrowseStates> {
  Browseviewmodel() : super(BrowseInitialState());

  List<Genres> categoryNames = [];

  void getBrowseNames() async {
    try {
      emit(BrowseLoadingStates());
      var response = await ApiManager.getCategoryNames();

      emit(BrowseSuccessStates(response: response));
    } catch (e) {
      emit(
          BrowseErrorStates(errorMessage: e.toString())); 
    }
  }
}
