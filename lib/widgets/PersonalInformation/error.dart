import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/config/palette.dart';

class ErrorScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Text("Not Found"),
        FlatButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: Text("Back"),
        )
      ],
    );
  }
}
