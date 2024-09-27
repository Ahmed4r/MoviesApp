

abstract class BrowseStates {}

class BrowseInitialState extends BrowseStates {}

class BrowseLoadingStates extends BrowseStates {}

class BrowseSuccessStates extends BrowseStates {
  var response;

  BrowseSuccessStates({required this.response});
}

class BrowseErrorStates extends BrowseStates {
  final String errorMessage;

  BrowseErrorStates({required this.errorMessage});
}
