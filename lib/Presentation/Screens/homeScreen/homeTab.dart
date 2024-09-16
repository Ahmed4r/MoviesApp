import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/cubit/hometabStates.dart';

import 'package:movies_app/data/api/Api_manger.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';
import 'package:movies_app/widgets/customviewMovies.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTab extends StatefulWidget {
  static const String routename = "HomeTab";

  @override
  State<HomeTab> createState() => _HomeTabState();
}

late Future<List<Movie>> popularMovies;

class _HomeTabState extends State<HomeTab> {
  @override
  void initState() {
    super.initState();
    popularMovies = ApiManager.getAllTopSide();
  }

  final Uri _url = Uri.parse('https://www.youtube.com/watch?v=gUTtJjV852c');
  final Map<String, bool> _favorites = {
    '1': true,
    '2': false,
  }; // Map to track favorite status

  void toggleBookmark(String movieId) {
    setState(() {
      _favorites[movieId] = !(_favorites[movieId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: popularMovies,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error.toString()}'));
        } else if (!snap.hasData || snap.data!.isEmpty) {
          return Center(child: Text('No data available'));
        }

        final data = snap.data!;
        final moive0 = data[0];

        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 49.h),
                Stack(
                  children: [
                    Container(
                      width: 412.w,
                      height: 289.h,
                      color: Colors.black,
                    ),
                    SizedBox(
                      width: 412.w,
                      height: 217.h,
                      child: Image.network(
                        '${Const.imagepath}${moive0.posterPath}', // Ensure this is a full URL or handle base URL
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 190.w,
                      top: 90.h,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: Colors.white,
                        ),
                        child: IconButton(
                          onPressed: _launchUrl,
                          icon: Icon(
                            Icons.play_arrow,
                            size: 50.sp,
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      top: 75.h,
                      // bottom: 40,
                      right: 280,
                      left: -90,
                      child: Stack(
                        children: [
                          Image.network(
                            '${Const.imagepath}${moive0.backdropPath}', // Ensure this is a full URL or handle base URL
                            filterQuality: FilterQuality.high,
                            fit: BoxFit.cover,
                          ),
                          Positioned(
                            top: -8.h,
                            left: -11.w,
                            child: IconButton(
                              onPressed: () {
                                toggleBookmark('unique_movie_id');
                              },
                              icon: Icon(
                                _favorites['unique_movie_id'] == true
                                    ? Icons.bookmark_add_outlined
                                    : Icons.bookmark_added_outlined,
                                color: Colors.white,
                                size: 30.sp,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Positioned(
                      left: 140.w,
                      top: 220.h,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${moive0.title}', // Replace with actual movie title
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 14.sp,
                            ),
                          ),
                          Text(
                            '${moive0.releaseDate}${moive0.popularity}', // Replace with actual movie details
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10.sp,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                Container(
                  color: const Color(0xff282A28),
                  height: 187.h,
                  width: 455.w,
                  child: Customviewmovies(
                    snapshot: snap,
                    movieId: '1',
                    onToggleFavorite: toggleBookmark,
                    title: 'New Releases',
                  ),
                ),
                SizedBox(height: 30.h),
                Container(
                  color: const Color(0xff282A28),
                  height: 187.h,
                  width: 455.w,
                  child: Customviewmovies(
                    snapshot: snap,
                    title: 'Recommended',
                    movieId: 'another_unique_movie_id',
                    onToggleFavorite: toggleBookmark,
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _launchUrl() async {
    if (!await launchUrl(
      _url,
      mode: LaunchMode.inAppWebView,
      webViewConfiguration: const WebViewConfiguration(enableJavaScript: true),
    )) {
      throw Exception('Could not launch $_url');
    }
  }
}
