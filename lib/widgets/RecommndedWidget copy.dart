import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/api/Api_manger.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';

class Recommndedwidget extends StatelessWidget {
  final Future<HometabResponse> snapshot;
  final bool isfav;
  final String title;
  final VoidCallback toggleBookmark;

  Recommndedwidget({
    required this.snapshot,
    required this.isfav,
    required this.title,
    required this.toggleBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<HometabResponse>(
      future: snapshot,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          final movies = snapshot.data?.results ?? [];
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
                    return SizedBox(width: 25.w);
                  },
                  scrollDirection: Axis.horizontal,
                  itemCount: movies.length,
                  itemBuilder: (context, index) {
                    final movie = movies[index];
                    return Stack(
                      children: [
                        Image.network(
                          '${Const.imagepath}${movie.posterPath}',
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
        return Center(child: Text('No data available'));
      },
    );
  }
}
