import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';

class Customviewmovies extends StatelessWidget {
  final bool isfav;
  final AsyncSnapshot<List<Movie>> snapshot;
  final String title;

  final VoidCallback toggleBookmark;

  Customviewmovies({
    required this.isfav,
    required this.snapshot,
    super.key,
    required this.title,
    required this.toggleBookmark,
  });

  @override
  Widget build(BuildContext context) {
    // Ensure the snapshot has data
    if (!snapshot.hasData) {
      return const Center(child: Text('No data available'));
    }

    final List<Movie> movies = snapshot.data!;
    // final movie0=movies[0];

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
                  Image.network(
                    '${Const.imagepath}${movie.posterPath}', // Ensure this is a full URL or handle base URL
                    filterQuality: FilterQuality.high,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: -12.h,
                    right: 88.w,
                    child: IconButton(
                      onPressed: toggleBookmark,
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
  }
}
