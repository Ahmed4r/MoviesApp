// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/homeTab.dart';
import 'package:movies_app/Shared/Text_Theme.dart';
import 'package:movies_app/data/api/MovieDetailsApi/MDStates.dart';
import 'package:movies_app/data/api/MovieDetailsApi/MovieDetailsCubit.dart';

import 'package:url_launcher/url_launcher.dart';

import 'package:movies_app/model/hometabmodel/hometabResponse.dart';

class MovieDetailsPage extends StatelessWidget {
  static const String routeName = 'MovieDetailsPage';
  Moviedetailscubit moviecubit = Moviedetailscubit();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ?? <String, dynamic>{}) as Map;

    final id = arguments['movieID'];

    final data = arguments['movieslist'] ;

    return Container(
        height: double.infinity,
        width: double.infinity,
        child: BlocBuilder<Moviedetailscubit, MovieDetailsStates>(

            // bloc: moviecubit..getMovie(id),

            bloc: moviecubit..getMovie(id),
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
                              Navigator.pop(context);
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
                                        final Uri url = Uri.parse(
                                            'https://www.imdb.com/title/${moviecubit.movie.imdbId}');
                                        _launchUrl(url);
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
                                                  MainAxisAlignment.start,
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
                                                    moviecubit.movie.genres![0].name??'',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),
                                                ),
                                                // Container(
                                                //   padding: EdgeInsets.symmetric(
                                                //       horizontal: 10,
                                                //       vertical: 8),
                                                //   decoration: BoxDecoration(
                                                //     border: Border.all(
                                                //         color: Colors.white24),
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             8.r),
                                                //   ),
                                                //   child: Text(
                                                //     'Adventure',
                                                //     style: TextStyle(
                                                //       color: Colors.white,
                                                //       fontSize: 13.sp,
                                                //     ),
                                                //   ),
                                                // ),
                                                // Container(
                                                //   padding: EdgeInsets.symmetric(
                                                //       horizontal: 10,
                                                //       vertical: 8),
                                                //   decoration: BoxDecoration(
                                                //     border: Border.all(
                                                //         color: Colors.white24),
                                                //     borderRadius:
                                                //         BorderRadius.circular(
                                                //             8),
                                                //   ),
                                                //   child: Text(
                                                //     'Family',
                                                //     style: TextStyle(
                                                //       color: Colors.white,
                                                //       fontSize: 13,
                                                //     ),
                                                //   ),
                                                // )
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
                              Container(
                                height: 200.h,
                                child: ListView.builder(
                                  scrollDirection: Axis.horizontal,
                                  itemCount: data.length,
                                  itemBuilder: (context, index) {
                                    return InkWell(
                                      onTap: () {
                                        Navigator.pushNamed(
                                            context, MovieDetailsPage.routeName,
                                            arguments: {
                                              'movieID':
                                                  data[index].id.toString(),
                                              "movieslist": data
                                            });
                                      },
                                      child: MovieCard(
                                          rate: data[index]
                                              .voteAverage
                                              .toString(),
                                          title: data[index].title ?? "",
                                          imageUrl:
                                              "https://image.tmdb.org/t/p/original${data[index].posterPath}" ??
                                                  ""),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
            }));
  }

  Future<void> _launchUrl(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    )) {
      throw Exception('Could not launch $url');
    }
  }
}

class MovieCard extends StatelessWidget {
  final String title;
  final String imageUrl;
  final String rate;

  const MovieCard(
      {required this.title, required this.imageUrl, required this.rate});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 130.w,
      height: 200.h,
      color: const Color.fromARGB(136, 48, 48, 48),
      margin: EdgeInsets.only(right: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                child: Image.network(
                  imageUrl,
                  width: 100.w,
                  fit: BoxFit.cover,
                  height: 130.h,
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
                rate,
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 12.sp,
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
