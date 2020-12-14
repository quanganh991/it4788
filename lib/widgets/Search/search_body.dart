import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fakebook_homepage/models/models.dart';
import 'package:fakebook_homepage/models/recent_searched.dart';
import 'package:fakebook_homepage/widgets/PersonalInformation/view_one_s_profile.dart';
import 'package:flutter/material.dart';
import 'package:fakebook_homepage/widgets/Personal/profile_avatar.dart';
import 'package:fakebook_homepage/controllers/Search/search_people.dart';
class SearchBody extends StatefulWidget {
  final bool folded;
  final bool result;
  final TextEditingController editingController;
  final users_models currentUser;

  const SearchBody({
    Key key,
    @required this.folded, this.result,
    @required this.editingController,
    @required this.currentUser,
}) : super(key:key);

  @override
  _SearchBodyState createState() => _SearchBodyState(currentUser: currentUser, editingController: editingController, folded: folded, result: result);
}

class _SearchBodyState extends State<SearchBody> {

  final bool folded;
  final bool result;
  final TextEditingController editingController;
  final users_models currentUser;

  _SearchBodyState({Key key, this.folded, this.result, this.editingController, this.currentUser, this.allSearchedUsers}) : super();

  Future<List<users_models>> allSearchedUsers;
  Future<List<recent_searched>> recentSearched;

  @override
  void initState() {
    super.initState();
    allSearchedUsers = Search.GetAllPeopleMatching(currentUser.id_users.toString(), "");
    recentSearched = Search.get_recent_keyword(currentUser.id_users.toString());
  }

  @override
  Widget build(BuildContext context) {

    return
      (((result == false && folded == false) || result == true) && editingController.text == "") //ấn lên thanh tìm kiếm và chưa nhập gì hoặc đã nhập xong rồi hoặc chưa ấn lên thanh tìm kiếm

        ?

      Column(  //fold == false

        children: [

          Container(
            height: 30,
            margin: EdgeInsets.only(left: 10, top: 20),
            child: Row(
              children: [
                Text("Recent Searches", style: TextStyle(fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),),
                SizedBox(width: 50,),
                FlatButton(onPressed: () {  },
                child: Text("Enter"))
              ],
            ),
          ),

          new Divider(color: Colors.grey),


     FutureBuilder(
      future: Search.get_recent_keyword(currentUser.id_users.toString()),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
            return Card(  //cả 1 listView
            margin: EdgeInsets.symmetric(horizontal: 0.0),
            elevation: 0.0,
            child: Container(
              height: 230,
              child: ListView.builder(
          //khung chứa các bài đăng của người dùng
              padding: const EdgeInsets.symmetric(
                      vertical: 10.0,
                      horizontal: 0.0,
                    ),
            itemCount: snapshot.data.length,
            itemBuilder: ((context, index) {
            //ListView
            return FlatButton(

              onPressed: () {
                // //gọi API lưu từ khóa đó lại
                // Search.save_search_keyword(currentUser.id_users.toString(), editingController.text.toString());
                print("------------đã lưu 123 " + editingController.text.toString());
                // //rồi mới điều hướng sang trang mới
                editingController.text = snapshot.data[index].keyword.toString();
                setState(() {
                });
              },
              child: Row(
                children: [
                  SizedBox(width: 15,),
                  Text(snapshot.data[index].keyword.toString(), style: TextStyle(color: Colors.black),),
                ],
              ),
            );
            //ListView


          }),
          ),


          ),
          );
        }
        return Container();
      },
    ),
          new Divider(color: Colors.grey, indent: 15,),
        ],
      )


:



   // else if(result == false && folded == true) //ấn lên thanh tìm kiếm và đang nhập
      Column(  //fold == false
        children: [
          Container(
            height: 30,
            margin: EdgeInsets.only(left: 10, top: 20),
            child: Row(
              children: [
                Text("Recent Searches", style: TextStyle(fontSize: 18,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),),
                SizedBox(width: 50,),
                FlatButton(onPressed: () {  },
                    child: Text("Enter"))
              ],
            ),
          ),

          new Divider(color: Colors.grey),


          FutureBuilder(
            future: Search.GetAllPeopleMatching(currentUser.id_users.toString(), editingController.text.toString()),  //không lưu gì hết
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return Card(  //cả 1 listView
                  margin: EdgeInsets.symmetric(horizontal: 0.0),
                  elevation: 0.0,
                  child: Container(
                    height: 230,
                    child: ListView.builder(
                      //khung chứa các bài đăng của người dùng
                      padding: const EdgeInsets.symmetric(
                        vertical: 10.0,
                        horizontal: 0.0,
                      ),
                      itemCount: snapshot.data.length,
                      itemBuilder: ((context, index) {
                        //ListView
                        return FlatButton(

                          onPressed: () {
                            //gọi API lưu từ khóa đó lại
                            Search.save_search_keyword(currentUser.id_users.toString(), editingController.text.toString());
                            print("------------đã lưu 567 " + editingController.text.toString());

                            //rồi mới điều hướng sang trang mới
                            Navigator.push(
                                context,
                                new MaterialPageRoute(
                                    builder: (context) =>
                                        ProfileScreen(
                                          currentUser: currentUser,
                                          viewedUser: snapshot.data[index],
                                        )
                                )
                            );
                          },
                          child: Row(
                            children: [
                              ProfileAvatar(
                                radius: 15.0,
                                imageUrl: snapshot.data[index].avatar.toString(),),
                              SizedBox(width: 15,),
                              Text(snapshot.data[index].name.toString(), style: TextStyle(color: Colors.black),),
                            ],
                          ),
                        );
                        //ListView


                      }),
                    ),


                  ),
                );
              }
              return Container();
            },
          ),
          new Divider(color: Colors.grey, indent: 15,),
        ],
      );
  }
}