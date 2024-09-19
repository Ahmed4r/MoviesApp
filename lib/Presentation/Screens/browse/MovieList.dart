import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movies_app/Presentation/Screens/browse/MovieCard.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/Discover%20ViewModel.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/DiscoverStates.dart';
import 'package:movies_app/Presentation/Screens/browse/cubit/browsestates.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/Movie_details.dart';

class MovieList extends StatelessWidget {
  final int genreId;
  final String genreName;

  MovieList({required this.genreId, required this.genreName});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => BrowseViewModel()..getMoviesByGenre(genreId),
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(genreName, style: TextStyle(color: Colors.white)),
          backgroundColor: Colors.black,
          elevation: 0,
        ),
        body: BlocBuilder<BrowseViewModel, BrowseStates>(
          builder: (context, state) {
            if (state is MovieListLoadingState) {
              return Center(child: CircularProgressIndicator());
            } else if (state is MovieListSuccessState) {
              final movies = state.movieResponse.results ?? [];
              return Padding(
                padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
                child: GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 20,
                    childAspectRatio: 0.65, // Aspect ratio to fit items correctly
                  ),
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Moviecard(
                      title: movie.title ?? 'Unknown',
                      posterPath: movie.posterPath,
                      rate: movie.voteAverage.toString(),
                      onTap: () {

                         Navigator.pushNamed(
                                          context, MovieDetailsPage.routeName,
                                          arguments: {
                                            'movieID': movie.id.toString(),
                                            'movieslist': movies
                                          });
                        // Navigate to movie details screen
                        // Navigator.of(context).pushNamed(
                        //   MovieDetailsPage.routeName,
                        //   arguments: movie.id,
                        // );
                      },
                    );
                  },
                ),
              );
            } else if (state is MovieListErrorState) {
              return Center(child: Text('Error: ${state.errorMessage}', style: TextStyle(color: Colors.white)));
            } else {
              return Center(child: Text('No data available', style: TextStyle(color: Colors.white)));
            }
          },
        ),
      ),
    );
  }
}
