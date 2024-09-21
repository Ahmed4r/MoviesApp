import 'package:movies_app/model/Browse/CategoryNameResponse.dart';

abstract class Browsestates {}

class BrowseLoadingStates extends Browsestates {}

class BrowseErrorStates extends Browsestates {
  String errorMessage;
  BrowseErrorStates({required this.errorMessage});
}

class BrowseSuccessStates extends Browsestates {
  CategoryNameResponse response;
  BrowseSuccessStates({required this.response});
}

class BrowseInitialStates extends Browsestates {}


