import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class WatchListTab extends StatelessWidget {
  static const String routename = 'watchlisttab';
  final List<String> movieImages = [
    'assets/dora.jpeg',
    'assets/dora.jpeg',
    'assets/dora.jpeg',
    // 'assets/images/eee.png',
    // 'assets/images/OIP.jfif',
    // 'assets/images/z.jfif',
    // 'assets/images/ww.jfif',
    // 'assets/images/zzz.jfif',
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
    '2014\nThe film is set in a dystopian future where Earth is slowly becoming uninhabitable due to environmental collapse',
    '1999\nA computer hacker known as "Neo," who discovers that the world he lives in is a simulated reality created by sentient machines to enslave humanity',
    '2003\nThe story follows Marlin, an overly cautious clownfish',
    '2009\n"Sharks" is a thrilling underwater adventure that delves into the enigmatic world of these majestic predators',
    '2010\nThe film follows Dom Cobb, a skilled thief who specializes in the art of "extraction"',
    '2015\nThe story takes viewers on a unique journey inside the mind of an 11-year-old girl named Riley, exploring the complex emotions that guide her thoughts and actions.',
  ];

  @override
  Widget build(BuildContext context) {
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
