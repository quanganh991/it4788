import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/widgets/PostFromMine/post.dart';
import 'package:fakebook_homepage/widgets/widgets.dart';
import 'package:url_launcher/url_launcher.dart';

class CreatePostContainer extends StatelessWidget {
  final users_models currentUser;


  const CreatePostContainer({
    Key key,
    @required this.currentUser,
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
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 0.0),
      elevation: 0.0,
      shape : null,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12.0, 8.0, 12.0, 0.0),
        color: Colors.white,
        child: Column(
          children: [
            Row(
              children: [
                ProfileAvatar(imageUrl: currentUser.avatar.toString()),

                //const SizedBox(width: 8.0),
                Expanded(
                  child: FlatButton(
                    // decoration: InputDecoration.collapsed(
                    //   hintText: 'What\'s on your mind?',
                    // ),
                    child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text('What\'s on your mind?', textDirection: TextDirection.ltr,)),
                    onPressed: ()=>{  //chuyển sang trang viết post, truyền vào User currentUser

                      Navigator.push(context, new MaterialPageRoute(
                          builder: (context) => CreatePost(currentUser: currentUser,))
                      )
                    },
                  ),
                )
              ],
            ),
            const Divider(height: 10.0, thickness: 0.5),
            Container(  //live, photo, room
              height: 40.0,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FlatButton.icon(
                    onPressed: () => print('Live'),
                    icon: const Icon(
                      Icons.videocam,
                      color: Colors.red,
                    ),
                    label: Text('Live'),
                  ),
                  const VerticalDivider(width: 8.0),
                  FlatButton.icon(
                    onPressed: () => {
                      getImage(),
                      print('Photo'),
                    },
                    icon: const Icon(
                      Icons.photo_library,
                      color: Colors.green,
                    ),
                    label: Text('Photo'),
                  ),
                  const VerticalDivider(width: 8.0),
                  FlatButton.icon(
                    onPressed: () => print('Room'),
                    icon: const Icon(
                      Icons.video_call,
                      color: Colors.purpleAccent,
                    ),
                    label: Text('Room'),
                  ),
                ],
              ),
            ),  //live, photo, room
          ],
        ),
      ),
    );
  }
}
