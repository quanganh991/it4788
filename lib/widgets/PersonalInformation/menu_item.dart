import 'package:flutter/material.dart';

class MenuItem extends StatelessWidget {
  final Icon icon;
  final String tittle;
  final String subTittle;

  const MenuItem({Key key, @required this.icon, this.tittle, this.subTittle}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      child: FlatButton(
        padding: EdgeInsets.all(0),
        child: Container(
          width: (MediaQuery.of(context).size.width - 30) / 2,
          padding: EdgeInsets.all(15.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              icon,
              SizedBox(height: 5.0,),
              Text(tittle, style: TextStyle(fontWeight: FontWeight.bold),),
              Container(
                padding: subTittle == null ? null : EdgeInsets.only(top: 5.0),
                child: subTittle == null ? null : Row(
                  children: [
                    Icon(Icons.brightness_1, size: 8.0, color: Colors.red,),
                    SizedBox(width: 5.0,),
                    Text(subTittle)
                  ],
                ),
              )
            ],
          ),
        ),
        onPressed: (){
          print(tittle);
        },
      ),
    );
  }
}
