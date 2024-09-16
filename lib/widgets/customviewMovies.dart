import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';

class Customviewmovies extends StatefulWidget {
  final AsyncSnapshot<List<Movie>> snapshot;
  final String title;
  final String movieId; // Unique identifier for each movie
  final Function(String) onToggleFavorite;

  Customviewmovies({
    required this.snapshot,
    super.key,
    required this.title,
    required this.movieId,
    required this.onToggleFavorite,
  });

  @override
  State<Customviewmovies> createState() => _CustomviewmoviesState();
}

class _CustomviewmoviesState extends State<Customviewmovies> {
  @override
  Widget build(BuildContext context) {
    // Ensure the snapshot has data
    if (!widget.snapshot.hasData) {
      return Center(child: Text('No data available'));
    }

    final List<Movie> movies = widget.snapshot.data!;

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
        SizedBox(
          height: 127.h,
          width: 400.w,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: movies.length,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context, index) {
              final movie = movies[index];
              return Stack(
                children: [
                  Container(
                    child: Image.network(
                      '${Const.imagepath}${movie.posterPath}', // Ensure this is a full URL or handle base URL
                      filterQuality: FilterQuality.high,
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: 5.h, // Adjusted for better positioning
                    right: 10.w, // Adjusted for better positioning
                    child: IconButton(
                      onPressed: () {
                        widget.onToggleFavorite(movie.id.toString());
                      },
                      icon: Icon(
                        widget.movieId == movie.id.toString()
                            ? Icons.bookmark_added_outlined
                            : Icons.bookmark_add_outlined,
                        color: Colors.white,
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
  }
}
