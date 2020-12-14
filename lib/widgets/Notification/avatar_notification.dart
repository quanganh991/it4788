import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/config/palette.dart';

class AvatarNotification extends StatelessWidget {
  final String imageUrl;
  final IconData icon;
  final Color circleColor;

  const AvatarNotification(
      {Key key,
      @required this.imageUrl,
      this.icon,
      this.circleColor = Colors.green
      })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.all(3.0),
          child: CircleAvatar(
            radius: 20, //bán kính hình tròn chứa avatar của từng người
            backgroundColor: Palette.facebookBlue,
            child: CircleAvatar(
              radius: 20,
              backgroundColor: Colors.grey[200], //0xFFEEEEEE
              backgroundImage: CachedNetworkImageProvider(imageUrl),
            ),
          ),
        ),
        Positioned(
          //đang online
          bottom:
              0.0,
          right:
              0.0,
          child: Container(
              height:
                  25.0,
              width:
                  25.0,
              decoration: BoxDecoration(
                //sáng xanh online
                color: circleColor,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 15, color: Colors.white,)),
        ) //đang offline
      ],
    );
  }
}
