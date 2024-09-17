import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/data/api/Api_manger.dart';
import 'package:movies_app/data/api/MovieDetailsApi/MDStates.dart';
import 'package:movies_app/data/api/MovieDetailsApi/movie_details_response.dart';

class Moviedetailscubit extends Cubit<MovieDetailsStates> {
  Moviedetailscubit() : super(MovieDetailsInichialStates());
  MovieDetailsResponse movie = MovieDetailsResponse();
  void getMovie(String movieID) async {
    try {
      emit(MovieDetailsLoudingStates());
      print("loadiiing");
      var response = await ApiManger.getMovie(movieID);
      if (response.success == false) {
        emit(MovieDetailsErorrStates(erorrMessage: response.status_message!));
        print("errrrorrr ${response.status_message!}");
      } else {
        movie = response;
        emit(MovieDetailsSuccessStates(response: response));
        print("success");
      }
    } catch (e) {
      emit(MovieDetailsErorrStates(erorrMessage: e.toString()));
    }
  }
}
