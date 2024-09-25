import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/Movie_details.dart';
import 'package:movies_app/data/FireStore/FireStore.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/model/hometabmodel/RecommendedResponse.dart';

class Recommndedwidget extends StatefulWidget {
  final Future<List<RecommdedData>> snapshot;
  final String title;
  final Map<int, bool>
      favoriteMovies; // Add favoriteMovies to track favorite status
  final Function(int) toggleBookmark; // Pass function to toggle bookmark status

  Recommndedwidget({
    required this.snapshot,
    required this.title,
    required this.favoriteMovies, // Accept favoriteMovies map
    required this.toggleBookmark, // Accept toggleBookmark callback
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

                      return Column(
                        children: [
                          Stack(
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
                                  height: 150.h,
                                  width: 120.w,
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
                                    if (isfav) {
                                      // If it's in the watchlist, remove it
                                      Firestore.removeMovieByTitle(
                                          movie.title!);
                                    } else {
                                      // If it's not in the watchlist, add it
                                      Firestore.addMovieToFirestore(
                                          context,
                                          movie.title ?? '',
                                          '${Const.imagepath}${movie.posterPath}' ??
                                              '',
                                          movie.overview ?? "");
                                    }
                                    widget.toggleBookmark(movie.id ?? 1);
                                  },
                                  icon: Icon(
                                    isfav
                                        ? Icons.bookmark_added
                                        : Icons.bookmark_add,
                                    color: isfav ? Colors.yellow : Colors.white,
                                    size: 31.sp,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            color: Color(0xff282A28),
                            width: 110,
                            height: 110,
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    SizedBox(
                                      width: 20,
                                    ),
                                    Icon(
                                      Icons.star,
                                      color: Colors.amber,
                                      size: 20,
                                    ),
                                    Text(
                                      '${movie.voteAverage}',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                ),
                                Text(
                                  '${movie.title}',
                                  style: TextStyle(color: Colors.white),
                                ),
                                Row(
                                  children: [
                                    Text(
                                      movie.releaseDate! ?? '',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          )
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
