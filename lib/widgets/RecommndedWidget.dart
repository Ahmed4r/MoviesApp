import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/Movie_details.dart';
import 'package:movies_app/data/FireStore/FireStore.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/model/hometabmodel/RecommendedResponse.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';

class Recommndedwidget extends StatefulWidget {
  final Future<List<RecommdedData>> snapshot;
  final String title;
  final Map<int, bool> favoriteMovies;
  final Function(Movie) onToggleBookmark; // Updated to use Movie object

  Recommndedwidget({
    required this.snapshot,
    required this.title,
    required this.favoriteMovies,
    required this.onToggleBookmark,
    super.key,
  });
  Future<bool> getFav(String title) async {
    return await Firestore.isMovieInWatchlist(title);
  }

  @override
  State<Recommndedwidget> createState() => _RecommndedwidgetState();
}

class _RecommndedwidgetState extends State<Recommndedwidget> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecommdedData>>(
      future: widget.snapshot,
      builder: (context, snap) {
        if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error.toString()}'));
        } else if (!snap.hasData || snap.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final data = snap.data!;
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h),
            Text(
              widget.title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 23.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.h),
            Expanded(
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(width: 10.w);
                },
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final movie = data[index];

                  // Use FutureBuilder to handle async check for each movie's favorite status
                  return FutureBuilder<bool>(
                    future: Firestore.isMovieInWatchlist(movie.title!),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Center(
                            child:
                                CircularProgressIndicator()); // Optional: Show loading indicator
                      }

                      if (snapshot.hasError) {
                        return Center(
                            child: Text(
                                'Error: ${snapshot.error}')); // Optional: Error handling
                      }

                      final isfav =
                          snapshot.data ?? false; // Check if movie is favorited

                      return Stack(
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                MovieDetailsPage.routeName,
                                arguments: {
                                  'movieID': movie.id.toString(),
                                  'movieslist': data
                                },
                              );
                            },
                            child: Image.network(
                              height: 400.h,
                              width: 110.w,
                              '${Const.imagepath}${movie.posterPath}', // Ensure this is a full URL or handle base URL
                              filterQuality: FilterQuality.high,
                              fit: BoxFit.cover,
                            ),
                          ),
                          Positioned(
                            top: -5.h,
                            right: 75.w,
                            child: IconButton(
                              onPressed: () async {
                                // Create a Movie object from the RecommdedData
                                final movieObj = Movie(
                                  id: movie.id,
                                  title: movie.title,
                                  posterPath: movie.posterPath,
                                  overview: movie.overview,
                                  isFavorite: isfav,
                                  // Add other required fields with default values
                                  adult: false,
                                  backdropPath: '',
                                  genreIds: const [],
                                  originalLanguage: '',
                                  originalTitle: '',
                                  popularity: 0,
                                  releaseDate: '',
                                  video: false,
                                  voteAverage: 0,
                                  voteCount: 0,
                                );
                                
                                // Call the parent's toggle handler
                                await widget.onToggleBookmark(movieObj);
                              },
                              icon: Icon(
                                isfav
                                    ? Icons.bookmark_added_outlined
                                    : Icons.bookmark_add_outlined,
                                color: isfav ? Colors.yellow : Colors.white,
                                size: 31.sp,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
