import 'package:fakebook_homepage/models/users_models.dart';
import 'package:fakebook_homepage/widgets/Personal/profile_avatar.dart';
import 'package:fakebook_homepage/widgets/PersonalInformation/view_one_s_profile.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/widgets/PersonalInformation/menu_item.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';

// import '../widgets/profile_avatar.dart';

class MenuScreen extends StatefulWidget {
  @override
  final users_models currentUser;
  MenuScreen({Key key, this.currentUser}) : super(key: key);

  _MenuScreenState createState() => _MenuScreenState(currentUser: currentUser);
}

class _MenuScreenState extends State<MenuScreen> {
  final users_models currentUser;

  _MenuScreenState({Key key, this.currentUser});



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Menu"),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
          )
        ],
      ),

      body: ListView(
        padding: EdgeInsets.all(5.0),
        children: [

          FlatButton(
            padding: const EdgeInsets.all(8.0),
            child:
                FlatButton(

                        onPressed: () { Navigator.push(
                            context,
                            new MaterialPageRoute(
                                builder: (context) => ProfileScreen(currentUser: currentUser, viewedUser: currentUser)
                            )); },
                        child:
            Row(
              children: [
                ProfileAvatar(radius: 20, imageUrl: currentUser.avatar.toString()),
                SizedBox(width: 10,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(currentUser.name.toString(), style: TextStyle(color: Colors.black87, fontWeight: FontWeight.bold),),
                    Text("View your profile", style: TextStyle(color: Colors.black54),)
                  ],
                )
              ],
            ),
                    ),

            onPressed: (){
              print("Profile");
              // Navigator.push(context, new MaterialPageRoute(
              //     builder: (context) => Scaffold())
              //);
            },
          ),

          Divider(
            indent: 8.0,
            endIndent: 8.0,
          ),

          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Column(
                  children: [
                    MenuItem(icon: Icon(Icons.people, color: Colors.blueAccent,), tittle: "Friend",),
                    MenuItem(icon: Icon(Icons.store, color: Colors.blueAccent,), tittle: "Marketplace",),
                    MenuItem(icon: Icon(Icons.update, color: Colors.blueAccent,), tittle: "Memories",),
                    MenuItem(icon: Icon(Icons.favorite, color: Colors.pinkAccent,), tittle: "Dating",),
                    MenuItem(icon: Icon(Icons.dashboard, color: Colors.blueAccent,), tittle: "Gaming",),
                  ],
                ),

                Column(
                  children: [
                    MenuItem(icon: Icon(Icons.flag, color: Colors.orangeAccent,), tittle: "Pages",),
                    MenuItem(icon: Icon(MdiIcons.accountGroup, color: Colors.blueAccent,), tittle: "Groups",),
                    MenuItem(icon: Icon(Icons.ondemand_video, color: Colors.blueAccent,), tittle: "Videos on Watch", subTittle: "1 new video",),
                    MenuItem(icon: Icon(Icons.event, color: Colors.redAccent,), tittle: "Events",),
                    MenuItem(icon: Icon(Icons.business_center, color: Colors.orangeAccent,), tittle: "Jobs",),
                    MenuItem(icon: Icon(Icons.bookmark, color: Colors.purpleAccent,), tittle: "Saved",),
                  ],
                )
              ],
            ),
          ),

          Divider(),

          ExpansionTile(
            title: Text("Help & Support"),
            leading: Icon(Icons.help),
            children: [
              Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                    children: [
                      Icon(Icons.donut_large),
                      SizedBox(width: 10,),
                      Text("Help Center")
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                    children: [
                      Icon(Icons.inbox),
                      SizedBox(width: 10,),
                      Text("Support Inbox")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                    children: [
                      Icon(Icons.report_problem),
                      SizedBox(width: 10,),
                      Text("Report a Problem")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                    children: [
                      Icon(Icons.book),
                      SizedBox(width: 10,),
                      Text("Term & Policies")
                    ],
                  ),
                ),
              )
            ],
          ),

          Divider(),

          ExpansionTile(
            title: Text("Settings & Privacy"),
            leading: Icon(Icons.settings),
            children: [
              Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                    children: [
                      Icon(Icons.account_circle),
                      SizedBox(width: 10,),
                      Text("Settings")
                    ],
                  ),
                ),
              ),

              SizedBox(height: 10,),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                    children: [
                      Icon(Icons.lock),
                      SizedBox(width: 10,),
                      Text("Privacy Shortcuts")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                    children: [
                      Icon(Icons.access_time),
                      SizedBox(width: 10,),
                      Text("Your time on Facebook")
                    ],
                  ),
                ),
              ),
              SizedBox(height: 10,),

              Card(
                margin: EdgeInsets.symmetric(horizontal: 8.0),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 15.0),
                  child: Row(
                    children: [
                      Icon(Icons.language),
                      SizedBox(width: 10,),
                      Text("Term & Policies")
                    ],
                  ),
                ),
              )
            ],
          ),

          Divider(),

          FlatButton(
            padding: EdgeInsets.all(0),
            child: ListTile(
              title: Text("Log Out"),
              leading: Icon(Icons.content_copy),
              
            ),
            onPressed: (){
              Navigator.popUntil(context, ModalRoute.withName(Navigator.defaultRouteName));
            },
          )

        ],
      ),
    );
  }
}




















