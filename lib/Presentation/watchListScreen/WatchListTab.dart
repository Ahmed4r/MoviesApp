import 'package:flutter/material.dart';

class WatchListTab extends StatelessWidget {
  static const String routename = 'watchlisttab';

  const WatchListTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
            height: double.infinity,
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.transparent,
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('lib/assets/images/splash.png')),
            ),
           ));
  }
}
