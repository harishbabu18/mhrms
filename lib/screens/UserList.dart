import 'dart:async';
import 'dart:convert';
import 'package:url_launcher/url_launcher.dart';


import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'CreateUser.dart';


class UserList extends StatefulWidget {
  @override
  UserListPageState createState() => new UserListPageState();
}

class UserListPageState extends State<UserList> {
  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }


  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull("http://192.168.1.3:8080/user"),
        headers: {
          "Accept": "application/json"
        }
    );

    this.setState(() {
      data = json.decode(response.body);
    });



    return "Success!";
  }

  @override
  void initState(){
    this.getData();
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text("List User"),
      ),
      body: /*new GridView.builder(gridDelegate: null, itemBuilder: null),*/new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return new Card(
            child:new Row( children: <Widget>[new Column(children: <Widget>[RaisedButton.icon(
              onPressed: /*_launchURL(data[index]["email"],"Job Oppertunity","Job Oppertunity")*/null,
              icon: Icon(Icons.email),
              label: Text("E-Mail"),
              color: Colors.cyanAccent,
            ),RaisedButton.icon(
              onPressed: () {},
              icon: Icon(Icons.message),
              label: Text("Message"),
              color: Colors.cyanAccent,
            )],),new Column(
                children: <Widget>[new Text(data[index]["firstName"],style:TextStyle(fontSize: 20) ,),
                                   new Text(data[index]["lastName"]),
                                   new Text(data[index]["email"]),
                                   new Text(data[index]["mobile"]),

                ]) ,
              new Column(
                  children: <Widget>[RaisedButton.icon(
                    onPressed: () {},
                    icon: Icon(Icons.phone),
                    label: Text("Call"),
                    color: Colors.cyanAccent,
                  ),
                    RaisedButton.icon(
                      onPressed: () => launch("tel://"+data[index]["mobile"]),
                      icon: Icon(Icons.edit),
                      label: Text("Edit"),
                      color: Colors.cyanAccent,
                    )

                  ]) ,
          ]),);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => CreateUser()),
          );
        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
