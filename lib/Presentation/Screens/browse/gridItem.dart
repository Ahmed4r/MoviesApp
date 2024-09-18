import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String genreName;

  const GridItem({Key? key, required this.genreName}) : super(key: key);

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
            InkWell(
                child: Image.network(
                  'https://siskiyou.sou.edu/wp-content/uploads/2022/03/intro-1644532027.webp',
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: double.infinity,
                ),
                onTap: () {}), // Handle tap if needed
            Center(
              child: Text(
                genreName,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
