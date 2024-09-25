// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/cubit/favcubit.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/homeTab.dart';
import 'package:movies_app/Provider/Provider.dart';
import 'package:movies_app/Shared/Text_Theme.dart';
import 'package:movies_app/data/FireStore/FireStore.dart';
import 'package:movies_app/data/api/MovieDetailsApi/MDStates.dart';
import 'package:movies_app/data/api/MovieDetailsApi/MovieDetailsCubit.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/widgets/bottomNav.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';

import 'package:url_launcher/url_launcher.dart';

class MovieDetailsPage extends StatelessWidget {
  static const String routeName = 'MovieDetailsPage';
  Moviedetailscubit moviecubit = Moviedetailscubit();

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final id = arguments['movieID'];

    final data = arguments['movieslist'];
    if (moviecubit.movie.id == null || moviecubit.movie.id != id) {
      moviecubit.getMovie(id);
    }

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
                          actions: [
                            IconButton(
                                onPressed: () {
                                  Navigator.popUntil(context,
                                      ModalRoute.withName(HomeTab.routename));
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => HomeScreen()),
                                  );
                                },
                                icon: Icon(Icons.home),
                                color: Colors.white)
                          ],
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
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    moviecubit.movie.title ?? "",
                                    style: TextThemee.bodyLargeWhite,
                                  ),
                                  Container(
                                    width: 100.w,
                                    child: TextButton(
                                        onPressed: () {
                                          Firestore.addMovieToFirestore(
                                              context,
                                              moviecubit.movie.title ?? "",
                                              '${Const.imagepath}${moviecubit.movie.posterPath}' ??
                                                  "",
                                              moviecubit.movie.overview ?? "");
                                        },
                                        child: Text(
                                          "Add To WatchList",
                                          style: TextThemee.bodymidWhite.copyWith(
                                              color: Colors.amber, fontSize: 15),
                                        )),
                                  )
                                ],
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
                                          "https://image.tmdb.org/t/p/original${moviecubit.movie.backdropPath}",
                                          height: 200.h,
                                          width: 150.w,
                                          fit: BoxFit.cover,
                                          scale: 3,
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
                                                    moviecubit.movie.genres !=
                                                                null &&
                                                            moviecubit
                                                                .movie
                                                                .genres!
                                                                .isNotEmpty
                                                        ? moviecubit
                                                                .movie
                                                                .genres![0]
                                                                .name ??
                                                            ''
                                                        : "No Genre Available",
                                                    style: TextStyle(
                                                      color: Colors.white,
                                                      fontSize: 15.sp,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                            SizedBox(
                                              height: 13.h,
                                            ),
                                            Container(
                                              width: 150,
                                              child: ReadMoreText(
                                                style: TextStyle(
                                                    color: Colors.white),
                                                moviecubit.movie.overview ?? '',
                                                trimMode: TrimMode.Line,
                                                trimLines: 4,
                                                colorClickableText: Colors.pink,
                                                trimCollapsedText: 'Show more',
                                                trimExpandedText: 'Show less',
                                                moreStyle: TextStyle(
                                                    color: Colors.pink,
                                                    fontSize: 14,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              // child: Text(
                                              //   moviecubit.movie.overview ??
                                              //       " ",
                                              //   // "Having spent most of her life exploring the jungle, nothing could prepare Dora for her most dangerous adventure yet — high school. ",
                                              //   style: TextStyle(
                                              //     fontSize: 16,
                                              //     color: Colors.white70,
                                              //   ),
                                              // ),
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
                                                          .toString()
                                                          .substring(0, 3) ??
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
                                          Navigator.pushNamed(context,
                                              MovieDetailsPage.routeName,
                                              arguments: {
                                                'movieID':
                                                    data[index].id.toString(),
                                                "movieslist": data
                                              });
                                        },
                                        child: FutureBuilder<bool>(
                                          future: Firestore.isMovieInWatchlist(
                                              data[index].title ?? ""),
                                          builder: (context, snapshot) {
                                            if (snapshot.connectionState ==
                                                ConnectionState.waiting) {
                                              return Container(
                                                  height: 50.h,
                                                  width: 50.w,
                                                  child:
                                                      CircularProgressIndicator()); // You can show a loading spinner while checking
                                            } else if (snapshot.hasError) {
                                              return Text(
                                                  'Error: ${snapshot.error}');
                                            } else if (snapshot.hasData &&
                                                snapshot.data == true) {
                                              // If the movie is in the watchlist
                                              return FavMovieCard(
                                                overView: data[index].overview,
                                                rate: data[index]
                                                    .voteAverage
                                                    .toString(),
                                                title: data[index].title ?? "",
                                                imageUrl:
                                                    "https://image.tmdb.org/t/p/original${data[index].posterPath}" ??
                                                        "",
                                              );
                                            } else {
                                              // If the movie is NOT in the watchlist
                                              return MovieCard(
                                                overView: data[index].overview,
                                                rate: data[index]
                                                    .voteAverage
                                                    .toString(),
                                                title: data[index].title ?? "",
                                                imageUrl:
                                                    "https://image.tmdb.org/t/p/original${data[index].posterPath}" ??
                                                        "",
                                              );
                                            }
                                          },
                                        ));
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

class MovieCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String rate;
  final String overView;

  const MovieCard({
    required this.title,
    required this.imageUrl,
    required this.rate,
    required this.overView,
  });

  @override
  State<MovieCard> createState() => _MovieCardState();
}

class _MovieCardState extends State<MovieCard> {
  bool fav = false;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(247, 31, 31, 31),
      ),
      width: 130.w,
      height: 200.h,
      margin: EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                child: Image.network(
                  widget.imageUrl,
                  width: 100.w,
                  fit: BoxFit.cover,
                  height: 130.h,
                ),
              ),
              Positioned(
                top: -8.h,
                left: -11.w,
                child: IconButton(
                  onPressed: () {
                    if (fav) {
                      Firestore.removeMovieByTitle(widget.title);
                      fav = false;
                      setState(() {});
                    } else {
                      Firestore.addMovieToFirestore(context, widget.title,
                          widget.imageUrl, widget.overView);
                      fav = true;
                      setState(() {});
                    }
                  },
                  icon: Icon(
                    fav
                        ? Icons.bookmark_added_outlined
                        : Icons.bookmark_add_outlined,
                    color: fav ? Colors.amber : Colors.white,
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
                widget.rate.substring(0, 3),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            widget.title,
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

class FavMovieCard extends StatefulWidget {
  final String title;
  final String imageUrl;
  final String rate;
  final String overView;

  const FavMovieCard({
    required this.title,
    required this.imageUrl,
    required this.rate,
    required this.overView,
  });

  @override
  State<FavMovieCard> createState() => _FavMovieCardState();
}

class _FavMovieCardState extends State<FavMovieCard> {
  bool fav = true;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30),
        color: const Color.fromARGB(247, 31, 31, 31),
      ),
      width: 130.w,
      height: 200.h,
      margin: EdgeInsets.only(right: 16.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Stack(
            children: [
              Container(
                child: Image.network(
                  widget.imageUrl,
                  width: 100.w,
                  fit: BoxFit.cover,
                  height: 130.h,
                ),
              ),
              Positioned(
                top: -8.h,
                left: -11.w,
                child: IconButton(
                  onPressed: () {
                    if (fav) {
                      Firestore.removeMovieByTitle(widget.title);
                      fav = false;
                      setState(() {});
                    } else {
                      Firestore.addMovieToFirestore(context, widget.title,
                          widget.imageUrl, widget.overView);
                      fav = true;
                      setState(() {});
                    }
                  },
                  icon: Icon(
                    fav
                        ? Icons.bookmark_added_outlined
                        : Icons.bookmark_add_outlined,
                    color: fav ? Colors.amber : Colors.white,
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
                widget.rate.substring(0, 3),
                style: TextStyle(
                  color: Colors.white,
                ),
              ),
            ],
          ),
          Text(
            widget.title,
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
