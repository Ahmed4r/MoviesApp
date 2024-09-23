import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/Movie_details.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/cubit/hometabStates.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/cubit/hometabViewmodel.dart';

import 'package:movies_app/Shared/app_color.dart';
import 'package:movies_app/data/FireStore/FireStore.dart';

import 'package:movies_app/data/api/Api_manger.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';
import 'package:movies_app/widgets/NewRealsesWidget.dart';
import 'package:movies_app/widgets/RecommndedWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTab extends StatefulWidget {
  static const String routename = "HomeTab";
  Hometabviewmodel viewmodel = Hometabviewmodel();

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  static Map<int, bool> favoriteMovies = {};
  bool isfav = false;
  late Future<HometabResponse> hometabResponse;
  MovieDetailsPage detailsPage = MovieDetailsPage();

  @override
  void initState() {
    super.initState();
    hometabResponse = ApiManager.getAllTopSide();
    widget.viewmodel.showMovies();
  }

  void toggleBookmark(int movieID) {
    setState(() {
      favoriteMovies[movieID] = !(favoriteMovies[movieID] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<Hometabviewmodel, HomeTabstates>(
      bloc: widget.viewmodel..showMovies(),
      builder: (BuildContext context, HomeTabstates state) {
        if (state is HomeTabLoadingState) {
          return Center(child: CircularProgressIndicator());
        } else if (state is HometabErrostates) {
          return Center(child: Text('Error: ${state.errorMessage}'));
        } else if (state is HometabSuccessStates) {
          final movies = state.response.results ?? [];
          // final primeMovie = movies[0];

          return Scaffold(
            // appBar: AppBar(
            //   leading: IconButton(
            //       onPressed: () async{
            //         await Firestore.removeAllMovies();
            //       },
            //       icon: Icon(Icons.abc_outlined)),
            // ),
            backgroundColor: Colors.black,
            body: SingleChildScrollView(
              child: Column(
                children: [
                  SizedBox(height: 50.h),
                  Container(
                    width: 412.w,
                    // height: 500.h,
                    color: Colors.black,
                  ),
                  movies.isNotEmpty
                      ? Container(
                          height: 310,
                          child: ImageSlideshow(

                              /// Auto scroll interval.
                              /// Do not auto scroll with null or 0.
                              autoPlayInterval: 5000,

                              /// Loops back to first slide.
                              isLoop: true,
                              initialPage: 0,

                              /// The color to paint the indicator.
                              indicatorColor: Colors.blue,

                              /// The color to paint behind th indicator.
                              indicatorBackgroundColor: Colors.grey,
                              children: [
                                //   for (int i = 0; i < sliderImages.length; i++)
                                //     sliderImages[i]
                                // )
                                for (int i = 0; i < movies.length; i++)
                                  Stack(
                                    children: [
                                      Container(
                                        width: 412.w,
                                        height: 500.h,
                                        color: Colors.black,
                                      ),
                                      movies.isNotEmpty
                                          ? Container(
                                              width: 412.w,
                                              height: 217.h,
                                              child: Image.network(
                                                '${Const.imagepath}${movies[i].posterPath}',
                                                filterQuality:
                                                    FilterQuality.high,
                                                fit: BoxFit.cover,
                                              ),
                                            )
                                          : Center(
                                              child:
                                                  CircularProgressIndicator()),
                                      Positioned(
                                        top: 77.h,
                                        left: 175.w,
                                        child: Container(
                                          decoration: BoxDecoration(
                                            borderRadius:
                                                BorderRadius.circular(40),
                                            color: const Color.fromARGB(
                                                255, 222, 214, 214),
                                          ),
                                          child: IconButton(
                                            onPressed: () async {
                                              // Fetch movie details
                                              detailsPage.moviecubit.getMovie(
                                                  movies[i].id.toString());

                                              // Check if movie data is available
                                              if (detailsPage
                                                      .moviecubit.movie !=
                                                  null) {
                                                final String imdbId =
                                                    detailsPage.moviecubit.movie
                                                            .imdbId ??
                                                        '';

                                                if (imdbId.isNotEmpty) {
                                                  final Uri url = Uri.parse(
                                                      '${Const.imdb}$imdbId');
                                                  print('Launching URL: $url');

                                                  // Launch URL
                                                  try {
                                                    await _launchUrl(url);
                                                  } catch (e) {
                                                    log('Error launching URL: $e');
                                                  }
                                                } else {
                                                  log('IMDb ID not found for movie: ${movies[i].title}');
                                                }
                                              } else {
                                                log('Movie details not available for movie: ${movies[i].title}');
                                              }
                                            },
                                            icon: Icon(
                                              Icons.play_arrow,
                                              size: 50.sp,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Positioned(
                                        left: 20,
                                        top: 100.h,
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Stack(
                                              children: [
                                                Container(
                                                  width: 129,
                                                  height: 180,
                                                  child: Image.network(
                                                    '${Const.imagepath}${movies.isNotEmpty ? movies[i].posterPath : ''}',
                                                    filterQuality:
                                                        FilterQuality.high,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                                
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                      Positioned(
                                        left: 160.w,
                                        top: 225.h,
                                        child: Row(children: [
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                '${movies.isNotEmpty ? movies[i].title : ''}',
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 24.sp,
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    '${movies.isNotEmpty ? movies[i].originalLanguage : ''}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(
                                                    '${movies.isNotEmpty ? movies[i].releaseDate : ''}',
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 14.sp,
                                                    ),
                                                  ),
                                                  IconButton(
                                                    onPressed: () {
                                                      Navigator.pushNamed(
                                                          context,
                                                          MovieDetailsPage
                                                              .routeName,
                                                          arguments: {
                                                            'movieID': movies[i]
                                                                .id
                                                                .toString(),
                                                            'movieslist': movies
                                                          });
                                                    },
                                                    icon: Icon(
                                                      Icons.info,
                                                      color: Colors.white,
                                                      size: 30,
                                                    ),
                                                  )
                                                ],
                                              ),
                                            ],
                                          ),
                                          SizedBox(width: 100.w),
                                        ]),
                                      ),
                                    ],
                                  ),
                              ]),
                        )
                      : Center(child: CircularProgressIndicator()),
                  Container(
                    color: const Color(0xff282A28),
                    height: 187.h,
                    width: 455.w,
                    child: Newrealseswidget(
                      snapshot: ApiManager.getNewRealeases(),
                      toggleBookmark: toggleBookmark,
                      favoriteMovies: favoriteMovies,
                      title: 'New Releases',
                    ),
                  ),
                  SizedBox(height: 30.h),
                  Container(
                    color: const Color(0xff282A28),
                    height: 187.h,
                    width: 455.w,
                    child: Recommndedwidget(
                      favoriteMovies: favoriteMovies,
                      toggleBookmark: toggleBookmark,
                      // isfav: isfav,
                      snapshot: ApiManager.getRecommended(),
                      title: 'Recommended',
                      // toggleBookmark: toggleBookmark,
                    ),
                  ),
                ],
              ),
            ),
          );
        }
        return Center(child: Text('No data available'));
      },
    );
  }

  Future<void> _launchUrl(Uri url) async {
    try {
      if (!await launchUrl(
        url,
        mode: LaunchMode
            .externalApplication, // Use the appropriate mode for launching externally
        webViewConfiguration:
            const WebViewConfiguration(enableJavaScript: true),
      )) {
        throw Exception('Could not launch $url');
      }
    } catch (e) {
      log('Failed to launch URL: $e');
    }
  }
}
