class Endpoints {
  //Home Screen
  static const String Recommended = '3/movie/top_rated';
  static const String New_Realeases = '3/movie/upcoming';
  static const String top_side_section = '3/movie/popular';

  //Movie Details:
  static const String Movie_Details = 'movie/{movie_id}';
  static const String more_like_this_section = 'movie/{movie_id}/similar';

  // Search Screen
  static const String search_for_move_name = 'search/movie';

  //Browse Categories Screen
  static const String BrowseCategory = 'genre/movie/list';
  static const String Discover_Movies = 'discover/movie';
}
