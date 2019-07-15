import 'package:flutter/material.dart';


class ListWithContact extends StatelessWidget {
  final String firstName;
  final String lastName;
  final String email;
  final String mobile;


  ListWithContact({this.firstName,
    this.lastName,
    this.email,
    this.mobile});

  @override
  Widget build(BuildContext context) {
    return Card(
      child:new Row( mainAxisAlignment: MainAxisAlignment.center,children: <Widget>[new Column(
          children: <Widget>[
            new Text(firstName,style:TextStyle(fontSize: 20) ,),
            new Text(lastName),
            new Text(email),
            new Text(mobile)
          ])
      ]),);
  }
}