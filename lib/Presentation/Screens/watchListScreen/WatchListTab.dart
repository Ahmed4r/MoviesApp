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
                          setState(() {});
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
  }
}
