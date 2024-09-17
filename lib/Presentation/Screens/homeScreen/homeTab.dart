import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/Movie_details.dart';
import 'package:movies_app/data/api/Api_manger.dart';
import 'package:movies_app/data/api/MovieDetailsApi/MovieDetailsCubit.dart';
import 'package:movies_app/data/api/const.dart';
import 'package:movies_app/model/hometabmodel/NewRealeases.dart';
import 'package:movies_app/model/hometabmodel/RecommendedResponse.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';
import 'package:movies_app/widgets/NewRealsesWidget.dart';
import 'package:movies_app/widgets/RecommndedWidget.dart';
import 'package:url_launcher/url_launcher.dart';

class HomeTab extends StatefulWidget {
  static const String routename = "HomeTab";

  const HomeTab({super.key});

  @override
  State<HomeTab> createState() => _HomeTabState();
}

late Future<List<Movie>> popularMovies;
late Future<List<Results>> NewrealeasesMovies;
late Future<List<RecommdedData>> RecommndedMovies;

class _HomeTabState extends State<HomeTab> {
  Moviedetailscubit movieCubit = Moviedetailscubit();
  final Map<int?, bool> _favoriteMovies = {};
  bool isfav = false;
  @override
  void initState() {
    super.initState();
    popularMovies = ApiManager.getAllTopSide();
    NewrealeasesMovies = ApiManager.getNewRealeases();
    RecommndedMovies = ApiManager.getRecommended();
  }

  final Uri _url = Uri.parse('https://www.youtube.com/watch?v=hJiPAJKjUVg');

  void toggleBookmark() {
    setState(() {
      isfav = !isfav;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Movie>>(
      future: popularMovies,
      builder: (context, snap) {
        if (snap.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snap.hasError) {
          return Center(child: Text('Error: ${snap.error.toString()}'));
        } else if (!snap.hasData || snap.data!.isEmpty) {
          return const Center(child: Text('No data available'));
        }

        final data = snap.data!;
        final moive0 = data[14];

        return Scaffold(
          backgroundColor: Colors.black,
          body: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: 50.h),
                Stack(
                  children: [
                    Container(
                      width: 412.w,
                      height: 300.h,
                      color: Colors.black,
                    ),
                    //image big
                    Container(
                      width: 412.w,
                      height: 217.h,
                      child: Image.network(
                        '${Const.imagepath}${moive0.posterPath}', // Ensure this is a full URL or handle base URL
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                    // icon play
                    Positioned(
                      top: 77.h,
                      left: 175.w,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(40),
                          color: const Color.fromARGB(255, 222, 214, 214),
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
                      left: 20,
                      top: 100.h,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Stack(
                            children: [
                              Container(
                                width: 129,
                                height: 180,
                                child: Image.network(
                                  '${Const.imagepath}${moive0.backdropPath}', // Ensure this is a full URL or handle base URL
                                  filterQuality: FilterQuality.high,
                                  fit: BoxFit.cover,
                                ),
                              ),
                              Positioned(
                                top: -9.h,
                                left: -11.w,
                                child: IconButton(
                                  onPressed: () {
                                    toggleBookmark();
                                  },
                                  icon: Icon(
                                    // bookmark_add_outlined
                                    isfav
                                        ? Icons.bookmark_added_outlined
                                        : Icons.bookmark_add_outlined,
                                    color: isfav ? Colors.yellow : Colors.white,
                                    size: 30.sp,
                                  ),
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
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${moive0.title}',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 24.sp,
                              ),
                            ),
                            Text(
                              '${moive0.releaseDate}  ${moive0.originalLanguage}', // Replace with actual movie details
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14.sp,
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          width: 10.w,
                        ),
                        IconButton(
                            onPressed: () async{

                              Navigator.pushNamed(
                                  context, MovieDetailsPage.routeName,arguments:{'movieID': moive0.id.toString(),"Data":data} );
                            },
                            icon: Icon(
                              Icons.info,
                              color: Colors.white,
                              size: 30,
                            ))
                      ]),
                    ),
                  ],
                ),
                Container(
                  color: const Color(0xff282A28),
                  height: 187.h,
                  width: 455.w,
                  child: Newrealseswidget(
                    snapshot: ApiManager.getNewRealeases(),
                    isfav: isfav,
                    toggleBookmark: toggleBookmark,
                    title: 'New Releases',
                  ),
                ),
                SizedBox(height: 30.h),
                Container(
                  color: const Color(0xff282A28),
                  height: 187.h,
                  width: 455.w,
                  child: Recommndedwidget(
                    isfav: isfav,
                    snapshot: ApiManager.getRecommended(),
                    title: 'Recommended',
                    toggleBookmark: toggleBookmark,
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
