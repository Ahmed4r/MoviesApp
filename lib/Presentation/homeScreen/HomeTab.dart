import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/homeScreen/build%20item.dart';
import 'package:movies_app/Presentation/homeScreen/new%20release%20item.dart';

class HomeTab extends StatelessWidget {
  static const String routename = 'hometab';

  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black87,
        child: Stack(
          children: [
            Positioned(
              top: 40.h,
              left: 20.w,
              right: 20.w,
              child: SizedBox(
                height: 200.h,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.movie,
                      size: 100.sp,
                      color: Colors.grey,
                    ),
                    SizedBox(width: 20.w),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Dora and the lost city of gold",
                            style: TextStyle(
                                fontSize: 18.sp,
                                fontWeight: FontWeight.bold,
                                color: Colors.white),
                          ),
                          SizedBox(height: 5.h),
                          Text(
                            "2019  PG-13  2h 7m",
                            style: TextStyle(color: Colors.grey[600]),
                          ),
                          SizedBox(height: 10.h),
                          IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.play_circle_fill,
                              color: Colors.grey,
                              size: 40.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 260.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "New Releases",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 150.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        BuildReleaseItem(
                          icon: Icons.movie,
                          title: "Narcos",
                          duration: "1h 45m",
                        ),
                        BuildReleaseItem(
                          icon: Icons.movie,
                          title: "Deadpool 2",
                          duration: "1h 59m",
                        ),
                        BuildReleaseItem(
                          icon: Icons.movie,
                          title: "Annabelle",
                          duration: "1h 30m",
                        ),
                        BuildReleaseItem(
                          icon: Icons.movie,
                          title: "Toy Story 4",
                          duration: "1h 40m",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned(
              top: 430.h,
              left: 20.w,
              right: 20.w,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Recommended",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  SizedBox(height: 10.h),
                  SizedBox(
                    height: 150.h,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: [
                        BuildRecommendedItem(
                          icon: Icons.movie,
                          title: "Deadpool 2",
                          duration: "1h 59m",
                          rating: "7.7",
                        ),
                        BuildRecommendedItem(
                          icon: Icons.movie,
                          title: "Deadpool 2",
                          duration: "1h 59m",
                          rating: "7.7",
                        ),
                        BuildRecommendedItem(
                          icon: Icons.movie,
                          title: "Deadpool 2",
                          duration: "1h 59m",
                          rating: "7.7",
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
