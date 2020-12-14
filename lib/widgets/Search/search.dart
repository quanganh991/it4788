import 'package:fakebook_homepage/models/users_models.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:fakebook_homepage/widgets/Search/search_body.dart';

class Search extends StatefulWidget {
  final users_models currentUser;
  const Search({Key key, this.currentUser}) : super(key: key);

  @override
  _SearchState createState() => _SearchState(currentUser: currentUser);
}

class _SearchState extends State<Search> {
  users_models currentUser;
  _SearchState({Key key, this.currentUser});

  bool _folded = false;
  bool _result = false;
  TextEditingController _editingController = new TextEditingController();



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        //backgroundColor: Colors.white,
        elevation: 1,
        actions: [
         Container(

           margin: EdgeInsets.all(9),

           width: 310,
           decoration: BoxDecoration(
             color: Colors.white,
             borderRadius: BorderRadius.all(Radius.circular(30))
           ),
           child: Padding(
             padding: const EdgeInsets.only(left: 10.0),
             child: TextField(
               controller: _editingController,
               decoration: InputDecoration(
                   //contentPadding: EdgeInsets.only(left: 10),

                   hintText: 'Search',
                   hintStyle: TextStyle(color: Colors.blue[300]),
                   border: InputBorder.none,
                 suffixIcon: _folded?IconButton(
                   icon: Icon(Icons.cancel, color: Colors.grey,),
                   iconSize: 20,
                   onPressed: (){
                    _editingController.clear();
                   },
                 ) : null
               ),
               onChanged: (string){ //khi người dùng đang nhập text

                 setState(() {
                   if(string != "") { //khi người dùng đang nhập
                     _folded = true;
                   }
                   else //khi người dùng chưa nhập gì
                     _folded = false;
                 }) ;

                 print("Tap");
               },
               onSubmitted: (str){  //khi người dùng ấn nhập xong
                 setState(() {
                   _result = true;
                 });
               },

               onTap: (){ //khi ấn lên thanh tìm kiếm
                 setState(() {
                   _result = false;
                 });
               },
             ),
           ),
         )
          ,
          //SizedBox(width: 100,)
        ],
      ),

      body: SearchBody(folded: _folded, editingController: _editingController, result: _result, currentUser: currentUser,),
    );
  }
}