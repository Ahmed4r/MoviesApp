import 'package:flutter/material.dart';
import 'package:movies_app/Shared/Text_Theme.dart';

showSnackBar(BuildContext context, String text) {
  return ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    backgroundColor: Colors.black,
    duration: Duration(seconds: 1),
    content: Text(
      text,
      style:
          TextThemee.bodymidWhite.copyWith(color: Colors.amber, fontSize: 15),
    ),
    
  ));
}
