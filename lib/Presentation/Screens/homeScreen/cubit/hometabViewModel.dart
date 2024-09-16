// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:movies_app/Presentation/Screens/homeScreen/cubit/hometabStates.dart';
// import 'package:movies_app/data/api/Api_manger.dart';
// import 'package:movies_app/model/hometabmodel/hometabResponse.dart';

// class Hometabviewmodel extends Cubit<HomeTabstates> {
//   Hometabviewmodel() : super(HomeTabInitalState());
//   List<Movie> topside = [];

//   void getTopSideview() async {
//     try {
//       emit(HomeTabLoadingState());
//       var response = await ApiManager.getAllTopSide();
//       emit(HometabSuccessStates(response: response));

//       print('done');
//     } catch (e) {
//       throw (e.toString());
//     }
//   }
// }
