// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables

import 'dart:ffi';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/browse/MovieList.dart';
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
                          title: AnimatedTextKit(
                              repeatForever: true,
                              pause: Duration(milliseconds: 1000),
                              animatedTexts: [
                                ColorizeAnimatedText(
                                  speed: Duration(milliseconds: 300),
                                  moviecubit.movie.originalTitle ?? '',
                                  textStyle: TextThemee.bodyLargeWhite,
                                  colors: [
                                    Colors.white,
                                    Colors.amber,
                                    Colors.white,
                                  ],
                                ),
                                ColorizeAnimatedText(
                                  speed: Duration(milliseconds: 300),
                                  "${moviecubit.movie.genres![0].name} Movie " ??
                                      '',
                                  textStyle: TextThemee.bodyLargeWhite,
                                  colors: [
                                    Colors.white,
                                    Colors.amber,
                                    Colors.white,
                                  ],
                                ),
                              ]),
                          centerTitle: true,
                        ),
                        body: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              Stack(
                                children: [
                                  CachedNetworkImage(
                                    height: 200.h,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    imageUrl:
                                        "https://image.tmdb.org/t/p/original${moviecubit.movie.backdropPath}",
                                    progressIndicatorBuilder:
                                        (context, url, downloadProgress) =>
                                            Transform.scale(
                                      scale: .25,
                                      child: CircularProgressIndicator(
                                          value: downloadProgress.progress),
                                    ),
                                    errorWidget: (context, url, error) =>
                                        Icon(Icons.error),
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
                                  Container(
                                    width: MediaQuery.of(context).size.width.w -
                                        100.w,
                                    child: Text(
                                      moviecubit.movie.title ?? "",
                                      style: TextThemee.bodyLargeWhite,
                                    ),
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
                                          style: TextThemee.bodymidWhite
                                              .copyWith(
                                                  color: Colors.amber,
                                                  fontSize: 15),
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
                                  Text(
                                    moviecubit.movie.originCountry != null
                                        ? moviecubit.movie.originCountry![0]
                                        : '',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                              SizedBox(height: 16),
                              Row(
                                children: [
                                  Stack(
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(5.r),
                                        child: Container(
                                          child: CachedNetworkImage(
                                            height: 200.h,
                                            width: 150.w,
                                            fit: BoxFit.cover,
                                            scale: 3,
                                            imageUrl:
                                                "https://image.tmdb.org/t/p/original${moviecubit.movie.posterPath}",
                                            progressIndicatorBuilder: (context,
                                                    url, downloadProgress) =>
                                                Transform.scale(
                                              scaleX: .25,
                                              scaleY: .25,
                                              child: CircularProgressIndicator(
                                                  value: downloadProgress
                                                      .progress),
                                            ),
                                            errorWidget:
                                                (context, url, error) =>
                                                    Icon(Icons.error),
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
                                                InkWell(
                                                  onTap: () {
                                                    Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                        builder: (context) =>
                                                            MovieList(
                                                          genreId: moviecubit
                                                                  .movie
                                                                  .genres![0]
                                                                  .id ??
                                                              0,
                                                          genreName: moviecubit
                                                                  .movie
                                                                  .genres![0]
                                                                  .name ??
                                                              "",
                                                        ),
                                                      ),
                                                    );
                                                  },
                                                  child: Container(
                                                    padding:
                                                        EdgeInsets.symmetric(
                                                            horizontal: 10,
                                                            vertical: 8),
                                                    decoration: BoxDecoration(
                                                      border: Border.all(
                                                          color:
                                                              Colors.white24),
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
                                                ),
                                                moviecubit.movie.genres!
                                                            .length ==
                                                        2
                                                    ? InkWell(
                                                        onTap: () {
                                                          Navigator.push(
                                                            context,
                                                            MaterialPageRoute(
                                                              builder:
                                                                  (context) =>
                                                                      MovieList(
                                                                genreId: moviecubit
                                                                        .movie
                                                                        .genres![
                                                                            1]
                                                                        .id ??
                                                                    0,
                                                                genreName: moviecubit
                                                                        .movie
                                                                        .genres![
                                                                            1]
                                                                        .name ??
                                                                    "",
                                                              ),
                                                            ),
                                                          );
                                                        },
                                                        child: Container(
                                                          margin:
                                                              EdgeInsets.only(
                                                                  left: 11),
                                                          padding: EdgeInsets
                                                              .symmetric(
                                                                  horizontal:
                                                                      10,
                                                                  vertical: 8),
                                                          decoration:
                                                              BoxDecoration(
                                                            border: Border.all(
                                                                color: Colors
                                                                    .white24),
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
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
                                                                        .genres![
                                                                            1]
                                                                        .name ??
                                                                    ''
                                                                : "No Genre Available",
                                                            style: TextStyle(
                                                              color:
                                                                  Colors.white,
                                                              fontSize: 15.sp,
                                                            ),
                                                          ),
                                                        ),
                                                      )
                                                    : SizedBox()
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
                                                    data[index].id.toString() ??
                                                        '',
                                                "movieslist": data ?? []
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
                                                  child: Transform.scale(
                                                      scaleX: .1,
                                                      scaleY: .1,
                                                      child:
                                                          CircularProgressIndicator())); // You can show a loading spinner while checking
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
        color: Colors.black,
      ),
      width: 130.w,
      height: 200.h,
      margin: EdgeInsets.symmetric(horizontal: 16.0),
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Stack(
              children: [
                Container(
                  child: CachedNetworkImage(
                    width: 100.w,
                    fit: BoxFit.cover,
                    height: 130.h,
                    imageUrl: widget.imageUrl,
                    progressIndicatorBuilder:
                        (context, url, downloadProgress) => Transform.scale(
                      scaleX: .25,
                      scaleY: .25,
                      child: CircularProgressIndicator(
                          value: downloadProgress.progress),
                    ),
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ),
                Positioned(
                  top: -8.h,
                  left: -11.w,
                  child: IconButton(
                    onPressed: () {
                      if (fav) {
                        Firestore.removeMovieByTitle(context, widget.title);
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
        color: Colors.black,
      ),
      width: 130.w,
      height: 200.h,
      margin: EdgeInsets.only(right: 16.0),
      child: SingleChildScrollView(
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
                        Firestore.removeMovieByTitle(context, widget.title);
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
      ),
    );
  }

  void idwithdetails(context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;

    final id = arguments['movieID'];
    Moviedetailscubit cubit = Moviedetailscubit();
    cubit.getMovie(id.toString());
    final imdp = '${Const.imdb}${cubit.movie.imdbId}';
  }
}
