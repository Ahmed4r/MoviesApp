import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:movies_app/Provider/Provider.dart';
import 'package:movies_app/Shared/Text_Theme.dart';
import 'package:movies_app/data/FireStore/FireStore.dart';
import 'package:provider/provider.dart';
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
        // actions: [
        //   IconButton(
        //       onPressed: () {
        //         Firestore.removeAllMovies();
        //          Future.delayed(const Duration(seconds: 1), () {
        //         setState(() {});
        //       });
        //       },
        //       icon: Row(
        //         children: [
        //           Text(
        //             "Delete All",
        //             style: TextThemee.bodymidWhite.copyWith(color: Colors.pink),
        //           ),
        //           Icon(Icons.delete_forever, color: Colors.pink)
        //         ],
        //       ))
        // ],
        title: Text(
          'Watch List',
          style: TextThemee.bodyLargeWhite,
        ),
        backgroundColor: Colors.black,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: Firestore.getFavMovies(),
        builder: (context, snapshot) {
          print('FutureBuilder snapshot state: ${snapshot.connectionState}');
          print('Has data: ${snapshot.hasData}');
          if (snapshot.hasError) {
            print('Error in FutureBuilder: ${snapshot.error}');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.error_outline, color: Colors.red, size: 60),
                  SizedBox(height: 16),
                  Text(
                    'Error loading watchlist',
                    style: TextThemee.bodymidWhite.copyWith(color: Colors.red),
                  ),
                  Text(
                    '${snapshot.error}',
                    style: TextThemee.bodymidWhite.copyWith(fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }
          
          if (snapshot.connectionState == ConnectionState.waiting) {
            print('Loading watchlist...');
            return Center(child: CircularProgressIndicator());
          } 
          
          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            print('No watchlist data available');
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(height: 100.h),
                  Icon(
                    Icons.movie_outlined,
                    color: Colors.grey[700],
                    size: 100,
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Your watchlist is empty",
                    style: TextThemee.bodymidWhite
                        .copyWith(color: Colors.grey[400], fontSize: 18),
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Add movies to your watchlist to see them here",
                    style: TextThemee.bodymidWhite
                        .copyWith(color: Colors.grey[600], fontSize: 14),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          // Data is available
          final favMovies = snapshot.data!;
          return Expanded(
            child: ListView.builder(
              itemCount: favMovies.length,
              itemBuilder: (context, index) {
                final movie = favMovies[index];
                return _buildWatchlistItem(movie);
              },
            ),
          );
        },
      ),
    );
  }

  Widget _buildWatchlistItem(Map<String, dynamic> movie) {
    return Container(
      color: Colors.black,
      margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Movie poster
          Container(
            width: 100,
            height: 130,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: Colors.grey[900],
            ),
            child: movie['imagePath']?.isNotEmpty == true
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      movie['imagePath'],
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return Center(
                          child: Icon(Icons.broken_image, color: Colors.grey[600]),
                        );
                      },
                    ),
                  )
                : Center(
                    child: Icon(Icons.movie, color: Colors.grey[600]),
                  ),
          ),
          
          // Movie details
          SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie['title'] ?? 'Unknown Title',
                  style: TextThemee.bodymidWhite.copyWith(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 4),
                ReadMoreText(
                  movie['description'] ?? 'No description available',
                  style: TextThemee.bodymidWhite.copyWith(
                    fontSize: 13,
                    fontWeight: FontWeight.w300,
                    color: Colors.grey[400],
                  ),
                  trimMode: TrimMode.Line,
                  trimLines: 2,
                  colorClickableText: Colors.pink,
                  trimCollapsedText: 'Show more',
                  trimExpandedText: 'Show less',
                  moreStyle: TextStyle(
                    color: Colors.pink,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          
          // Remove button
          IconButton(
            padding: EdgeInsets.zero,
            constraints: BoxConstraints(),
            onPressed: () {
              Firestore.removeMovieByTitle(context, movie['title']);
              setState(() {});
            },
            icon: Icon(
              Icons.bookmark_remove,
              color: Colors.amber,
              size: 28,
            ),
          ),
        ],
      ),
    );
  }
}
