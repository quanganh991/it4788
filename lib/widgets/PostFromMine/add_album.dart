import 'package:flutter/material.dart';

class AddToAlBum extends StatefulWidget {
  @override
  _AudienceState createState() => _AudienceState();
}

class _AudienceState extends State<AddToAlBum> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        title: Text('Add To Album'),
        actions: [
          FlatButton(
            onPressed: () {  },
            child: Text('Done', style: TextStyle(fontSize: 15, color: Colors.white, fontWeight: FontWeight.bold),),
          )
        ],
      ),
    );
  }
}