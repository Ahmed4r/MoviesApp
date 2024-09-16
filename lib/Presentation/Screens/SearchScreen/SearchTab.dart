import 'package:flutter/material.dart';

class SearchTab extends StatelessWidget {
  static const String routename = 'searchtab';

  const SearchTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black87,
      body: Column(
        children: [
          // Search bar
          SizedBox(
            height: 50,
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey.shade800,
                prefixIcon: Icon(Icons.search, color: Colors.white),
                hintText: 'Search',
                hintStyle: TextStyle(color: Colors.white70),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none,
                ),
              ),
              style: TextStyle(color: Colors.white),
            ),
          ),

          Spacer(),

          Column(
            children: [
              Icon(
                Icons.movie_creation_outlined,
                size: 100,
                color: Colors.grey,
              ),
              Text(
                'No movies found',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            ],
          ),
          Spacer(flex: 2),
        ],
      ),
    );
  }
}
