import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Customviewmovies extends StatefulWidget {
  final String title;
  final bool isFav;
  final String movieId; // Unique identifier for each movie
  final Function(String) onToggleFavorite;

  Customviewmovies({
    required this.title,
    this.isFav = false,
    required this.movieId,
    required this.onToggleFavorite,
  });

  @override
  State<Customviewmovies> createState() => _CustomviewmoviesState();
}

class _CustomviewmoviesState extends State<Customviewmovies> {
  @override
  Widget build(BuildContext context) {
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
        Container(
          height: 127.h,
          width: 400.w,
          child: GridView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: 17,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 1,
              crossAxisSpacing: 1,
              mainAxisSpacing: 1,
            ),
            itemBuilder: (context, index) {
              return Stack(
                children: [
                  Container(
                    child: Image.asset(
                      'assets/movie.png',
                      fit: BoxFit.cover,
                    ),
                  ),
                  Positioned(
                    top: -6.h,
                    right: 86.w,
                    child: IconButton(
                      onPressed: () {
                        widget.onToggleFavorite(widget.movieId);
                      },
                      icon: Icon(
                        widget.isFav
                            ? Icons.bookmark_add_outlined
                            : Icons.bookmark_added_outlined,
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
