import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
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
                onTap: () {}),
            Positioned(
              bottom: 10,
              left: 10,
              child: Text(
                'ACTION',
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
