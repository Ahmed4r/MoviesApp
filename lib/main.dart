import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/browse/BrowseListTab.dart';

import 'package:movies_app/widgets/bottomNav.dart';
import 'package:movies_app/Presentation/homeScreen/HomeTab.dart';
import 'package:movies_app/Presentation/SearchScreen/SearchTab.dart';
import 'package:movies_app/Presentation/watchListScreen/WatchListTab.dart';
import 'package:movies_app/Presentation/SplashScreen/splashScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(412, 870),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: SplashScreen.routename,
          routes: {
            SplashScreen.routename: (context) => SplashScreen(),
            HomeScreen.routename: (context) => HomeScreen(),
            BrowseListTab.routename: (context) => BrowseListTab(),
            HomeTab.routename: (context) => HomeTab(),
            SearchTab.routename: (context) => SearchTab(),
            WatchListTab.routename: (context) => WatchListTab(),
          },
        );
      },
    );
  }
}
