import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/Movie_details.dart';

class MovieList extends StatefulWidget {
  static const String routename = "MovieList";

  @override
  State<MovieList> createState() => _MovieListState();
}

class _MovieListState extends State<MovieList> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(
          'Movie List',
          style: TextStyle(color: Colors.white),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 10, 5, 10),
        child: Expanded(
          
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 10,
              mainAxisSpacing: 20,
        
            ),
            
            itemCount: 15,
            scrollDirection: Axis.vertical,
            itemBuilder: (context, index) {
              return MovieCard(
                  title: "a7a",
                  imageUrl:
                      "https://siskiyou.sou.edu/wp-content/uploads/2022/03/intro-1644532027.webp",
                  rate: "1111");
              // return Padding(
              //   padding: EdgeInsets.symmetric(horizontal: 12.w),
              //   child: Column(
              //     children: [
              //       Stack(
              //         children: [
              //           Container(
              //             width: 150.w, // Increased width
              //             height: 240.h, // Increased height
              //             decoration: BoxDecoration(
              //               borderRadius: BorderRadius.circular(10),
              //               image: DecorationImage(
              //                 image: NetworkImage(
              //                     'https://siskiyou.sou.edu/wp-content/uploads/2022/03/intro-1644532027.webp'), // Replace with actual poster URL
              //                 fit: BoxFit.cover,
              //               ),
              //             ),
              //           ),
              //         ],
              //       ),
              //       SizedBox(height: 12.h),
              //       Text(
              //         'Movie Title $index',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 16.sp,
              //         ),
              //       ),
              //       Text(
              //         'Release Date',
              //         style: TextStyle(
              //           color: Colors.white,
              //           fontSize: 14.sp,
              //         ),
              //       ),
              //     ],
              //   ),
              // );
            },
          ),
        ),
      ),
    );
  }
}
