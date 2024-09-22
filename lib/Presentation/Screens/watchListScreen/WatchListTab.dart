import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:movies_app/Shared/Text_Theme.dart';


class WatchListTab extends StatelessWidget {
  static const String routename = 'watchlisttab';
  final List<String> movieImages = [

    'assets/imagetitle.png',
    'assets/dora.jpeg',
    'assets/dora.jpeg',
    'assets/dora.jpeg',
    'assets/dora.jpeg',
    'assets/dora.jpeg',


  final List<String> movieTitles = [
    'Interstellar',
    'The Matrix',
    'Nemo',
    'Sharks',
    'Inception',
    'Inside Out',
  ];

  final List<String> movieDescriptions = [

    '2014\nThe film is set in a dystopian ',

    '1999\nA computer hacker known as "Neo," who discovers that the world he lives in is a simulated reality created by sentient machines to enslave humanity',
    '2003\nThe story follows Marlin, an overly cautious clownfish',
    '2009\n"Sharks" is a thrilling underwater adventure that delves into the enigmatic world of these majestic predators',
    '2010\nThe film follows Dom Cobb, a skilled thief who specializes in the art of "extraction"',
    '2015\nThe story takes viewers on a unique journey inside the mind of an 11-year-old girl named Riley, exploring the complex emotions that guide her thoughts and actions.',
  ];

  @override
  Widget build(BuildContext context) {

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        appBar: AppBar(
          title: Text(
            'Watchlist',
            style: TextThemee.bodyLargeWhite,
          ),
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
          itemCount: movieImages.length,
          itemBuilder: (context, index) {
            return _buildWatchlistItem(movieImages[index], movieTitles[index],
                movieDescriptions[index]);
          },
        ),

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text('Watchlist'),
        backgroundColor: Colors.white,
      ),
      body: ListView.builder(
        itemCount: movieImages.length,
        itemBuilder: (context, index) {
          return _buildWatchlistItem(
              movieImages[index], movieTitles[index], movieDescriptions[index]);
        },

      ),
    );
  }

  Widget _buildWatchlistItem(
      String imagePath, String title, String description) {

    return Container(
      padding: EdgeInsets.all(5),
        height: 100.h,
        margin: EdgeInsets.only(bottom: 15),
        color: Colors.black,
        child: Row(
          children: [
            Stack(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 10),
                  width: 200.w,
                  height: 200.h,
                  child: Image.asset(
                    imagePath,
                    fit: BoxFit.cover,
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
            Container(
              
              width: 200.w,
              child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Text(
                    description.substring(0, 30),
                    style: TextStyle(
                      color: Colors.grey,
                      fontSize: 14,
                      fontStyle: FontStyle.normal,
                    ),
                  ),
                ],
              ),
            )
          ],
        ));

    return Card(
      color: Colors.black12,
      child: ListTile(
          leading: Image.asset(
            imagePath,
            width: 120.w,
            height:90.h,
            fit: BoxFit.cover,
          ),
          title: Text(
            title,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
          subtitle: Text(
            description,
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
              fontStyle: FontStyle.normal,
            ),
          ),
          trailing: IconButton(
            onPressed: () {},
            icon: Icon(
              Icons.delete,
              color: Colors.red,
            ),
          )),
    );

  }
}
