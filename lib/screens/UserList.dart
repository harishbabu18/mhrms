import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mhrms/config/Config.dart';
import 'package:url_launcher/url_launcher.dart';
import 'CreateUser.dart';
import 'UserDetails.dart';

class UserList extends StatefulWidget {
  @override
  UserListPageState createState() => new UserListPageState();
}

class UserListPageState extends State<UserList> {
  String User_URL = Config.User_URL;
  _launchURL(String toMailId, String subject, String body) async {
    var url = 'mailto:$toMailId?subject=$subject&body=$body';
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  void _userdetails(String id){
    Navigator.push(context, MaterialPageRoute(builder: (context) => UserDetails(id:id)),
    );
  }


  List data;

  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(User_URL),
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
      /*appBar: AppBar(
        title: Text("List User"),
      ),*/
      body: new ListView.builder(
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
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
