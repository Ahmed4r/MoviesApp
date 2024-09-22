import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Presentation/Screens/SearchScreen/cubit/searchStates.dart';
import 'package:movies_app/data/api/Api_manger.dart';
import 'package:movies_app/model/searchmodel/searchResponse.dart';

class SearchCubit extends Cubit<Searchstates> {
  SearchCubit() : super(SearchInitState());

  List<SearchResults> searchResults = [];
  void deleteSearch() {
    searchResults.clear();
  }

  void searchMovie({required String search}) async {
    try {
      emit(SearchLoadingState());

      var response = await ApiManager.searchMovie(search);
      searchResults = response.results ?? [];

      emit(SearchSuccessState(response: response));
      print('Success: ${searchResults[0].title}');
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }
}
