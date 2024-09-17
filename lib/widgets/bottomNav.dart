import 'package:flutter/material.dart';
import 'package:movies_app/Presentation/Screens/browse/BrowseListTab.dart';

import 'package:movies_app/Presentation/Screens/SearchScreen/SearchTab.dart';
import 'package:movies_app/Presentation/Screens/homeScreen/homeTab.dart';

import 'package:movies_app/Presentation/Screens/watchListScreen/WatchListTab.dart';

class HomeScreen extends StatefulWidget {
  static const String routename = 'homeScreen';

  const HomeScreen({super.key});

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentIndex = 0;

  List<Widget> screens = [
    HomeTab(),
    SearchTab(),
    BrowseListTab(),
    WatchListTab(),
  ];

  void onTabTapped(int index) {
    setState(() {
      currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: screens[currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: onTabTapped,
        selectedItemColor: const Color(0xffFFBB3B),
        unselectedItemColor: Colors.grey,
        backgroundColor: Colors.black,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'HOME',
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'SEARCH',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie_creation_outlined),
            label: 'BROWSE',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bookmark_border),
            label: 'WATCHLIST',
          ),
        ],
      ),
    );
  }
}
