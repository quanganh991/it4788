import 'package:flutter/material.dart';

class Audience extends StatefulWidget {

  @override
  _AudienceState createState() => _AudienceState();
}

class _AudienceState extends State<Audience> {
  int audience;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Edit Audience'),
        actions: [
          FlatButton(
            onPressed: () { //trả kết quả về cho trang trước
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (context) => CreatePost (  //ẩn vào ảnh thì mở ảnh dưới dạng FULLPHOTO
              //             currentUser : null)
              //     ));
              Navigator.pop(context,audience.toString()); //gỡ intent khỏi stack
            },
            child: Text('Done', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),),
          )
        ],
      ),

      body: Column(
        children: [
          ListTile( //Public

            leading: Icon(Icons.public, size: 35, color: audience == 0 ? Colors.black : Colors.blueGrey,),
            title: Text('Public', style: TextStyle(color: audience == 0 ? Colors.black : Colors.blueGrey,),),
            subtitle: Text('Anyone on or off Facebook'),
            trailing: Radio(
              value: 0,
              groupValue: audience,
              activeColor: Colors.black,
              onChanged: (int val){
                setState(() {
                  audience = val;
                  print("-----------audience = " + audience.toString());
                });
              },
            ),
            onTap: (){
              setState(() {
                audience = 0;
                print("-----------audience = " + audience.toString());
              });
            },
          ),

          new Divider(indent: 70.0, color: Colors.grey, endIndent: 30,),

          ListTile(

            leading: Icon(Icons.people, size: 35, color: audience == 1 ? Colors.black : Colors.blueGrey,),
            title: Text('Friends', style: TextStyle(color: audience == 1 ? Colors.black : Colors.blueGrey,),),
            subtitle: Text('Your friends on Facebook'),
            trailing: Radio(
              value: 1,
              groupValue: audience,
              activeColor: Colors.black,
              onChanged: (int val){
                setState(() {
                  audience = val;
                  print("-----------audience = " + audience.toString());
                });
              },
            ),
            onTap: (){
              setState(() {
                audience = 1;
                print("-----------audience = " + audience.toString());
              });
            },
          ),

          new Divider(indent: 70.0, color: Colors.grey, endIndent: 30,),

          ListTile(
            leading: Icon(Icons.lock, size: 35, color: audience == 2 ? Colors.black : Colors.blueGrey,),
            title: Text('Only me', style: TextStyle(color: audience == 2 ? Colors.black : Colors.blueGrey,),),
            subtitle: Text('Only me'),
            trailing: Radio(
              value: 2,
              groupValue: audience,
              activeColor: Colors.black,
              onChanged: (int val){
                setState(() {
                  audience = val;
                  print("-----------audience = " + audience.toString());
                });
              },
            ),
            onTap: (){
              setState(() {
                audience = 2;
                print("-----------audience = " + audience.toString());
              });
            },
          ),

          new Divider(indent: 70.0, color: Colors.grey, endIndent: 30,),


        ],
      ),
    );
  }
}


/*
child: new Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [

            Expanded(
              flex: 1,
              child: new Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ProfileAvatar(imageUrl: currentUser.imageUrl),  //avatar
                  const SizedBox(width: 8.0),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text(currentUser.name, style: TextStyle(fontWeight: FontWeight.w600),),

                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          FlatButton(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Public'),

                            ),
                            onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => Audience())),
                          ),

                          FlatButton(
                            child: Align(
                              alignment: Alignment.center,
                              child: Text('Album'),

                            ),
                            onPressed: () => Navigator.push(context, new MaterialPageRoute(builder: (context) => Audience())),
                          )

                        ],
                      ),
                    ],
                  )
                ],

              ),
            ),
            Expanded(
              flex: 6,
              child: TextField(
                decoration: InputDecoration.collapsed(hintText: 'Write'),
              ),
            )
          ],
        ),
 */