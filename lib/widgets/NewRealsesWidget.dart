import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/Movie_details.dart';
import 'package:movies_app/Presentation/Screens/watchListScreen/WatchListTab.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/model/hometabmodel/NewRealeases.dart';

class Newrealseswidget extends StatelessWidget {
  final Future<List<Response>> snapshot;
  final String title;
  final Map<int, bool> favoriteMovies; // Map to track favorite status
  final Function(int) toggleBookmark; // Function to toggle bookmark by movieID

  Newrealseswidget({
    required this.snapshot,
    required this.title,
    required this.favoriteMovies, // Pass the favoriteMovies map
    required this.toggleBookmark, // Pass the toggleBookmark function
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Response>>(
      future: snapshot,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snap.hasError) {
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
              title,
              style: TextStyle(
                color: Colors.white,
                fontSize: 23.sp,
                fontWeight: FontWeight.w400,
              ),
            ),
            SizedBox(height: 10.h),
            SizedBox(
              height: 127.h,
              width: 400.w,
              child: ListView.separated(
                separatorBuilder: (context, index) {
                  return SizedBox(
                    width: 25.w,
                  );
                },
                scrollDirection: Axis.horizontal,
                itemCount: data.length,
                itemBuilder: (context, index) {
                  final movie = data[index];
                  final isfav = favoriteMovies[movie.id] ??
                      false; // Check if movie is favorited

                  return Stack(
                    children: [
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MovieDetailsPage.routeName, arguments: {
                            'movieID': movie.id.toString(),
                            'movieslist': data
                          });
                        },
                        child: Image.network(
                          '${Const.imagepath}${movie.posterPath}', // Ensure this is a full URL or handle base URL
                          filterQuality: FilterQuality.high,
                          fit: BoxFit.cover,
                        ),
                      ),
                      Positioned(
                        top: -12.h,
                        right: 44.w,
                        child: IconButton(
                          onPressed: () {

                            toggleBookmark(
                                movie.id ?? 1); // Toggle favorite status

                            toggleBookmark(movie.id ?? 1);

                            // Toggle favorite status
y
                          },
                          icon: Icon(
                            isfav
                                ? Icons.bookmark_added_outlined
                                : Icons.bookmark_add_outlined,
                            color: isfav ? Colors.yellow : Colors.white,
                            size: 30.sp,
                          ),
                        ),
                      ),
                    ],
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
