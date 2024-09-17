// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Shared/Text_Theme.dart';
import 'package:movies_app/data/api/MovieDetailsApi/MDStates.dart';
import 'package:movies_app/data/api/MovieDetailsApi/MovieDetailsCubit.dart';

class MovieDetailsPage extends StatelessWidget {
  static const String routeName = 'MovieDetailsPage';
  Moviedetailscubit moviecubit = Moviedetailscubit();
  @override
  Widget build(BuildContext context) {
    return Container(
        height: double.infinity,
        width: double.infinity,
        child: BlocBuilder<Moviedetailscubit, MovieDetailsStates>(
            bloc: moviecubit..getMovie("440"),
            builder: (context, state) {
              return state is MovieDetailsLoudingStates
                  ? Center(
                      child: CircularProgressIndicator(),
                    )
                  : Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Scaffold(
                        backgroundColor: Colors.black,
                        appBar: AppBar(
                          backgroundColor: Colors.black,
                          leading: IconButton(
                            icon: Icon(Icons.arrow_back, color: Colors.white),
                            onPressed: () {
                              // Navigator.pop(context);
                              // Handle back button press
                            },
                          ),
                          title: Text(
                            moviecubit.movie.originalTitle ?? '',
                            style: TextThemee.bodyLargeWhite,
                          ),
                          centerTitle: true,
                        ),
                        body: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  Image.network(
                                    // moviecubit.movie.backdropPath??

                                    "https://image.tmdb.org/t/p/original${moviecubit.movie.backdropPath}",
                                    height: 200.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                  Center(
                                    heightFactor: 1.7,
                                    // want make this responsive

                                    child: IconButton(
                                      onPressed: () {
                                        // Handle play button press
                                      },
                                      icon: Icon(
                                        Icons.play_circle,
                                        size: 90,
                                        color: const Color.fromARGB(
                                            197, 255, 255, 255),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.h),
                              Text(
                                moviecubit.movie.title ?? "",
                                style: TextThemee.bodyLargeWhite,
                              ),
                              SizedBox(height: 8.h),
                              Row(
                                children: [
                                  Text(
                                    moviecubit.movie.releaseDate ?? "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 10.w),
                                  Text(
                                    moviecubit.movie.originalLanguage ?? "",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  SizedBox(width: 10.w),
                                  // Text(
                                  //   '2h 7m',
                                  //   style: TextStyle(color: Colors.white),
                                  // ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      Container(
                                        child: Image.network(
                                          "https://image.tmdb.org/t/p/original${moviecubit.movie.posterPath}",
                                          height: 200.h,
                                          width: 150.w,
                                        ),
                                      ),
                                      Positioned(
                                        top: -8.h,
                                        left: -11.w,
                                        child: IconButton(
                                          onPressed: () {},
                                          icon: Icon(
                                            Icons.bookmark_add_outlined,
                                            color: Colors.white,
                                            size: 30.sp,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Expanded(
                                    child: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Container(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.stretch,
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: [
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white24),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    'Action',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.sp,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white24),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.r),
                                                  ),
                                                  child: Text(
                                                    'Adventure',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13.sp,
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  padding: EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8),
                                                  decoration: BoxDecoration(
                                                    border: Border.all(
                                                        color: Colors.white24),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8),
                                                  ),
                                                  child: Text(
                                                    'Family',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 13,
                                                    ),
                                                  ),
                                                )
                                              ],
                                            ),
                                            SizedBox(
                                              height: 13.h,
                                            ),
                                            Container(
                                              width: 150,
                                              child: Text(
                                                moviecubit.movie.overview ??
                                                    " ",
                                                // "Having spent most of her life exploring the jungle, nothing could prepare Dora for her most dangerous adventure yet — high school. ",
                                                style: TextStyle(
                                                  fontSize: 16,
                                                  color: Colors.white70,
                                                ),
                                              ),
                                            ),
                                            SizedBox(
                                              height: 13.h,
                                            ),
                                            Row(
                                              children: [
                                                Icon(Icons.star,
                                                    color: Colors.amber),
                                                SizedBox(width: 4),
                                                Text(
                                                  moviecubit.movie.voteAverage
                                                          .toString() ??
                                                      "",
                                                  style: TextStyle(
                                                      fontSize: 18,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      color: Colors.white),
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                              SizedBox(height: 16),
                              Text(
                                'More Like This',
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white),
                              ),
                              SizedBox(height: 16),
                              // Container(
                              //   height: 200.h,
                              //   child: ListView.builder(
                              //     scrollDirection: Axis.horizontal,
                              //     itemCount: moviecubit.movie.productionCompanies!.length,
                              //     itemBuilder: (context, index) {
                              //       return MovieCard(
                              //           title: moviecubit.movie.productionCompanies?[index].name??"",
                              //           imageUrl:
                              //               "https://image.tmdb.org/t/p/original${moviecubit.movie.productionCompanies?[index].logoPath}"??"");
                              //     },
                              //   ),
                              // ),
                            ],
                          ),
                        ),
                      ),
                    );
            }));
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;

  const MovieCard({required this.title, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 71, 71, 71),
      width: 120,
      margin: EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Stack(
            children: [
              Container(
                child: Image.network(
                  imageUrl,
                  width: 100,
                  fit: BoxFit.cover,
                  height: 100.h,
                ),
              ),
              Positioned(
                top: -8.h,
                left: -11.w,
                child: IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.bookmark_add_outlined,
                    color: Colors.white,
                    size: 30.sp,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 8.h),
          Row(
            children: [
              Icon(Icons.star, color: Colors.amber, size: 16),
              SizedBox(width: 4.w),
              Text(
                '7.7',
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16.sp,
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: 4.h),
        ],
      ),
    );
  }
}
