import 'package:flutter/material.dart';
import 'package:mhrms/screens/UserDetails.dart';


class ListWithContact extends StatelessWidget {
  List data;
  int index;
  ListWithContact(int index);

  @override
  Widget build(BuildContext context) {
    return InkWell(onTap: (){Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails(id:data[index]["id"].toString())));},
        child:new Card(
          child:new Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[new Column(
              children: <Widget>[
                new Text(data[index]["firstName"],style:TextStyle(fontSize: 20) ,),
                new Text(data[index]["lastName"]),
                new Text(data[index]["email"]),
                new Text(data[index]["mobile"]),

              ])
          ]),));
  }
}