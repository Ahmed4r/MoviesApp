import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Presentation/Screens/SearchScreen/SearchTab.dart';
import 'package:movies_app/Presentation/Screens/browse/BrowseListTab.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/Movie_details.dart';

import 'package:movies_app/Presentation/Screens/homeScreen/homeTab.dart';
import 'package:movies_app/Presentation/Screens/watchListScreen/WatchListTab.dart';
import 'package:movies_app/Presentation/SplashScreen/splashScreen.dart';
import 'package:movies_app/model/hometabmodel/hometabResponse.dart';
import 'package:movies_app/widgets/bottomNav.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
//   Platform.isAndroid
//       ? await Firebase.initializeApp(
// // Replace with actual values
//           options: FirebaseOptions(
//             apiKey: "AIzaSyAtnQm_VVzaunANl6hM5BVwl0BsfgHiIwM",
//             appId: "com.example.movies",
//             messagingSenderId: "348629568610",
//             projectId: "movies-app-95b8b",
//           ),
//         )
//       :
      //  await Firebase.initializeApp();

  // await FirebaseFirestore.instance.disableNetwork();
  Bloc.observer = MyBlocObserver();
  runApp(const MyApp());
}

class MyBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase bloc) {
    super.onCreate(bloc);
    print('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc bloc, Object? event) {
    super.onEvent(bloc, event);
    print('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase bloc, Change change) {
    super.onChange(bloc, change);
    print('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    super.onTransition(bloc, transition);
    print('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('onError -- ${bloc.runtimeType}, $error');
    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase bloc) {
    super.onClose(bloc);
    print('onClose -- ${bloc.runtimeType}');
  }
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
            HomeTab.routename: (context) => HomeTab(),
            MovieDetailsPage.routeName: (context) => MovieDetailsPage(),
            SplashScreen.routename: (context) => SplashScreen(),
            BrowseListTab.routename: (context) => BrowseListTab(),
            SearchTab.routename: (context) => SearchTab(),
            WatchListTab.routename: (context) => WatchListTab(),
          },
        );
      },
    );
  }
}
