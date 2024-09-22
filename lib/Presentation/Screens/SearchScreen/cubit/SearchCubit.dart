import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Presentation/Screens/SearchScreen/cubit/searchStates.dart';
import 'package:movies_app/data/api/Api_manger.dart';
import 'package:movies_app/model/searchmodel/searchResponse.dart';

class SearchCubit extends Cubit<Searchstates> {
  SearchCubit() : super(SearchInitState());

  List<SearchResults> searchResults = [];

  void searchMovie({required String search}) async {
    if (search.isEmpty) {
      emit(SearchInitState()); // Reset to initial state if search is empty
      return;
    }

    try {
      emit(SearchLoadingState());
      var response = await ApiManager.searchMovie(search);

      // Clear previous results
      searchResults = response.results ?? [];
      emit(SearchSuccessState(response: response));

      // Filter suggestions
      final suggestions = searchResults.where((element) {
        final movieTitle = element.title ?? 'no title';
        return movieTitle.toLowerCase().contains(search.toLowerCase());
      }).toList();

      emit(SearchSuccessState(response: SearchResponse(results: suggestions)));
      print('sucesssssssssssssssssssssssssssssssss${searchResults[0].title}');
      // print(suggestions);
    } catch (e) {
      emit(SearchErrorState(errorMessage: e.toString()));
    }
  }
}
