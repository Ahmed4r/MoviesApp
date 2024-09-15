import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class BuildRecommendedItem extends StatelessWidget {
  IconData icon;
  String title;
  String duration;
  String rating;

  BuildRecommendedItem({super.key, 
    required this.icon,
    required this.title,
    required this.duration,
    required this.rating,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(right: 10.w),
      width: 100.w,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, size: 80.sp, color: Colors.grey),
          SizedBox(height: 5.h),
          Text(
            title,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              fontSize: 14.sp,
            ),
            overflow: TextOverflow.ellipsis,
          ),
          Text(
            duration,
            style: TextStyle(color: Colors.grey, fontSize: 12.sp),
          ),
          Row(
            children: [
              Icon(Icons.star, color: Colors.yellow, size: 16.sp),
              SizedBox(width: 2.w),
              Text(
                rating,
                style: TextStyle(color: Colors.grey, fontSize: 12.sp),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
