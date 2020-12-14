import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';


class ListActionPost extends StatelessWidget {

  final keyboardVisible;
  const ListActionPost({
    Key key,
    @required this.keyboardVisible,
  }) : super(key: key);

  getImage() async {
    const url = 'https://vi.imgbb.com/';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return !keyboardVisible ? Container(
      width: size.width,
      child: Card(color: Colors.white,
        elevation: 10,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular((25)),
              topRight: Radius.circular(25)
          ),),
        // width: size.width,
        margin: EdgeInsets.only(top: size.height * 0.8),

        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              ListTile(
                leading: Icon(Icons.image, color: Colors.green,),
                title: Text('Image', style: TextStyle(fontWeight: FontWeight.w600),),
                onTap: (){
                  getImage();
                },
              ),
            ],
          ),
        ),
      ),
    ) :
    Align(
      alignment: Alignment.bottomCenter,
      child: Card(color: Colors.white,
        elevation: 10,
        shadowColor: Colors.black,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular((25)),
              topRight: Radius.circular(25)
          ),),
        // width: size.width,
        margin: EdgeInsets.only(bottom: 0),

         child: Row(
           mainAxisAlignment: MainAxisAlignment.center,
           children: [
             IconButton(
               icon: Icon(Icons.image, color: Colors.green,),
               onPressed: (){
                 getImage();
               },

             ),
           ],
         ),
      ),
    );
  }
}

