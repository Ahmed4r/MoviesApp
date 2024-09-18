import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/model/hometabmodel/NewRealeases.dart';

class Newrealseswidget extends StatelessWidget {
  final bool isfav;
  final Future<List<Results>> snapshot;
  final String title;

  final VoidCallback toggleBookmark;

  Newrealseswidget({
    required this.snapshot,
    required this.isfav,
    super.key,
    required this.title,
    required this.toggleBookmark,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Results>>(
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
          final moive0 = data[18];
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
        });
  }
}
