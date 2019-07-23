import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mhrms/config/Config.dart';

class UserDetails extends StatefulWidget {


  UserDetails({Key key, this.id}) : super(key: key);
  final String id;



  @override
  _UserDetailsState createState() => _UserDetailsState();
}

class _UserDetailsState extends State<UserDetails> {
  String User_URL = Config.User_URL;
  var data;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(User_URL+widget.id),
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
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Candidate Details"),
      ),
      body: Center(child:Container(child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(data["firstName"]),
            Text(data["lastName"]),
            Text(data["mobile"]),
            IconButton(
              icon: Icon(Icons.phone),
              padding: const EdgeInsets.all(8.0),
              color: Colors.blue,
              onPressed: null,
            ),
            RaisedButton(child: Text("International Call"),),
            Text(data["email"]),
            IconButton(
              icon: Icon(Icons.email),
              padding: const EdgeInsets.all(8.0),
              color: Colors.blue,
              onPressed: null,
            ),

      ]),) ,),
    );
  }

}