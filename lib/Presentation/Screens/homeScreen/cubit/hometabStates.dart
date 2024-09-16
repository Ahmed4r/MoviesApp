import 'package:movies_app/model/hometabmodel/hometabResponse.dart';

abstract class HomeTabstates {}

class HomeTabInitalState extends HomeTabstates {}

class HomeTabLoadingState extends HomeTabstates {}

class HometabErrostates extends HomeTabstates {
  String errorMessage;
  HometabErrostates({required this.errorMessage});
}

class HometabSuccessStates extends HomeTabstates {
  HometabResponse response;
  HometabSuccessStates({required this.response});
}
