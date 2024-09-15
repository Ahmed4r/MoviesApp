import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HomeTab extends StatelessWidget {
  static const String routename = "HomeTab";
  HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(
              height: 49,
            ),
            Stack(children: [
              Container(
                width: 412.w,
                height: 289.h,
                color: Colors.black,
              ),
              Container(
                width: 412.w,
                height: 217.h,
                child: Image.asset(
                  'lib/assets/images/imagetitle.png',
                  fit: BoxFit.fill,
                ),
              ),
              Positioned(
                left: 190,
                top: 90.h,
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(40),
                      color: Colors.white),
                  child: Icon(
                    Icons.play_arrow,
                    size: 50,
                  ),
                ),
              ),
              Positioned(
                  top: 75,
                  child: Stack(children: [
                    Container(
                      child: Image.asset('lib/assets/images/Image.png'),
                    ),
                    Icon(Icons.list)
                  ])),
              Positioned(
                  left: 140,
                  top: 220.h,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dora and the lost city of gold',
                        style: TextStyle(color: Colors.white, fontSize: 14),
                      ),
                      Text('2019  PG-13  2h 7m',
                          style: TextStyle(color: Colors.white, fontSize: 10)),
                    ],
                  ))
            ]),
            Container(
              color: Colors.grey,
              height: 187,
              width: 455,
            ),
            SizedBox(
              height: 30,
            ),
            Container(
              color: Colors.grey,
              height: 187,
              width: 455,
            ),
          ],
        ),
      ),
    );
  }
}
