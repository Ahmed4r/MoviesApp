import 'package:flutter_bloc/flutter_bloc.dart';

class WatchlistCubit extends Cubit<List<String>> {
  WatchlistCubit() : super([]);

  void addMovie(String title) {
    // Add movie to the state
    state.add(title);
    emit(List.from(state)); // Trigger state update
  }

  void removeMovie(String title) {
    // Remove movie from the state
    state.remove(title);
    emit(List.from(state)); // Trigger state update
  }

  bool isInWatchlist(String title) {
    return state.contains(title);
  }
}
