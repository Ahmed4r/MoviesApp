import 'package:bloc/bloc.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/DiscoverStates.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/browsestates.dart';
import 'package:movies_app/data/api/Api_manger.dart';

class BrowseViewModel extends Cubit<BrowseStates> {
  BrowseViewModel() : super(BrowseInitialState());

  void getBrowseNames() async {
    emit(BrowseLoadingStates());
    try {
      final response = await ApiManager.getCategoryNames();
      emit(BrowseSuccessStates(response: response));
    } catch (e) {
      emit(BrowseErrorStates( errorMessage:  e.toString(),));
    }
  }

  void getMoviesByGenre(int genreId) async {
    emit(MovieListLoadingState());
    try {
      final movieResponse = await ApiManager.getMoviesByGenre(genreId);
      emit(MovieListSuccessState(movieResponse));
    } catch (e) {
      emit(MovieListErrorState(e.toString()));
    }
  }
}
