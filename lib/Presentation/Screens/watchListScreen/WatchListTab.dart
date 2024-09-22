
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Shared/Text_Theme.dart';


class WatchListTab extends StatelessWidget {
  static const String routename = 'watchlisttab';
  final List<String> movieImages = [
    'assets/dora.jpeg',
    'assets/dora.jpeg',
    'assets/dora.jpeg',
    'assets/dora.jpeg',
    'assets/dora.jpeg',
    'assets/dora.jpeg',
  ];

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
          title: Text('Watchlist',style: TextThemee.bodyLargeWhite,),
          backgroundColor: Colors.black,
        ),
        body: ListView.builder(
          itemCount: movieImages.length,
          itemBuilder: (context, index) {
            return _buildWatchlistItem(
                movieImages[index],
                movieTitles[index],
                movieDescriptions[index]
            );
          },
        ),
        
      ),
    );
  }

  Widget _buildWatchlistItem(String imagePath, String title, String description) {
    return Card(
      color: Colors.black,
      child: ListTile(
        leading:  Stack(
                                    children: [
                                      Container(
                                        child: Image.asset(
                                          imagePath,
                                          height: 200.h,
                                          width: 150.w,
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
        trailing: Icon(
          Icons.check_box,
          color: Colors.yellow,
        ),
      ),
    );
  }
}
