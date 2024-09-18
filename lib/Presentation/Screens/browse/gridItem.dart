import 'package:flutter/material.dart';
import 'package:movies_app/Presentation/Screens/browse/MovieList.dart';

class GridItem extends StatelessWidget {
  final String genreName;
  final String imageUrl;

  GridItem({Key? key, required this.genreName, required this.imageUrl})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey.shade900,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Center(
        child: Stack(
          children: [
            Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
            Center(
              child: InkWell(
                onTap: () {
                  Navigator.of(context).pushNamed(MovieList.routename);
                },
                child: Text(
                  genreName,
                  style: TextStyle(
                      fontSize: 25,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
