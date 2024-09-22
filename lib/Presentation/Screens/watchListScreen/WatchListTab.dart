import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Shared/Text_Theme.dart';
import 'package:movies_app/data/FireStore/FireStore.dart';
import 'package:readmore/readmore.dart';


class WatchListTab extends StatefulWidget {
  static const String routename = 'watchlisttab';

  @override
  State<WatchListTab> createState() => _WatchListTabState();
}

class WatchListTab extends StatelessWidget {
  static const String routename = 'watchlisttab';
  final List<String> movieImages = [
    'assets/imagetitle.png',
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


class _WatchListTabState extends State<WatchListTab> {
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        title: Text(
          'watch list',
          style: TextThemee.bodyLargeWhite,
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Firestore.getFavMovies(), // Call the getFavMovies function
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return Center(
                child: Text(
              'No favorite movies found',
              style: TextThemee.bodymidWhite,
            ));
          }

          // Data is available
          final favMovies = snapshot.data!;
          return ListView.builder(
            itemCount: favMovies.length,
            itemBuilder: (context, index) {
              final movie = favMovies[index];
              return Container(
                color: Colors.black,
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      padding: EdgeInsets.only(right: 15),
                      width: 100,
                      height: 130,
                      child: Image.network(
                        movie['imagePath'] ?? '',
                        filterQuality: FilterQuality.high,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Container(
                      width: 200,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            movie['title'] ?? 'Unknown',
                            style: TextThemee.bodymidWhite,
                          ),
                          ReadMoreText(
                            style: TextThemee.bodymidWhite.copyWith(
                                fontSize: 15, fontWeight: FontWeight.w300),
                            movie['description'] ?? 'No description available',
                            trimMode: TrimMode.Line,
                            trimLines: 4,
                            colorClickableText: Colors.pink,
                            trimCollapsedText: 'Show more',
                            trimExpandedText: 'Show less',
                            moreStyle: TextStyle(
                                color: Colors.pink,
                                fontSize: 14,
                                fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    IconButton(
                        onPressed: () async {
                          await Firestore.removeMovieByTitle(movie['title']);
                          setState(() {
                            
                          });
                        },
                        icon: Icon(
                          Icons.bookmark_added_outlined,
                          color: Colors.amber,
                        ))
                    // ListTile(
                    //   dense: true,
                    //   visualDensity: VisualDensity(vertical: 4),
                    //   title: Text(
                    //     movie['title'] ?? 'Unknown',
                    //     style: TextThemee.bodymidWhite,
                    //   ),
                    //   subtitle: ReadMoreText(
                    //     style: TextThemee.bodymidWhite.copyWith(
                    //         fontSize: 15, fontWeight: FontWeight.w300),
                    //     movie['description'] ?? 'No description available',
                    //     trimMode: TrimMode.Line,
                    //     trimLines: 4,
                    //     colorClickableText: Colors.pink,
                    //     trimCollapsedText: 'Show more',
                    //     trimExpandedText: 'Show less',
                    //     moreStyle: TextStyle(
                    //         color: Colors.pink,
                    //         fontSize: 14,
                    //         fontWeight: FontWeight.bold),
                    //   ),
                    //   onTap: () {
                    //     // Handle movie tap (e.g., navigate to details page)
                    //   },
                    // ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
=======
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

  }
}
