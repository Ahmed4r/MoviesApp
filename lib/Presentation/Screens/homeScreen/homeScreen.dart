import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/widgets/customviewMovies.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTab extends StatefulWidget {
  static const String routename = "HomeTab";
  HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  final Uri _url = Uri.parse('https://www.youtube.com/watch?v=gUTtJjV852c');
  final Map<String, bool> _favorites = {
    '1': true,
    '2': false
  }; // Map to track favorite status

  void toggleBookmark(String movieId) {
    setState(() {
      _favorites[movieId] = !(_favorites[movieId] ?? false);
    });
  }

  @override
  Widget build(BuildContext context) {
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
                Container(
                  width: 412.w,
                  height: 217.h,
                  child: Image.asset(
                    'assets/imagetitle.png',
                    fit: BoxFit.fill,
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
                      onPressed: () {
                        _launchUrl();
                      },
                      icon: Icon(
                        Icons.play_arrow,
                        size: 50.sp,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  top: 75.h,
                  child: Stack(
                    children: [
                      Container(
                        child: Image.asset('assets/Image.png'),
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
                        'Dora and the Lost City of Gold',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 14.sp,
                        ),
                      ),
                      Text(
                        '2019  PG-13  2h 7m',
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
              color: Color(0xff282A28),
              height: 187.h,
              width: 455.w,
              child: Customviewmovies(
                movieId: '1',
                onToggleFavorite: toggleBookmark,
                title: 'New Releases',
                isFav: _favorites['1'] ?? false,
              ),
            ),
            SizedBox(height: 30.h),
            Container(
              color: Color(0xff282A28),
              height: 187.h,
              width: 455.w,

              child: Customviewmovies(
                title: 'Recommended',
                movieId: 'another_unique_movie_id',
                onToggleFavorite: toggleBookmark,
                isFav: _favorites['another_unique_movie_id'] ?? false,
              ),
              // child: Image.asset('lib/assets/images/icon.png'),
            ),
          ],
        ),
      ),
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
