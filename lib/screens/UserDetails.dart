import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mhrms/model/User.dart';
import 'package:http/http.dart' as http;


class UserDetails extends StatelessWidget {

  Future<User> fetchPost() async {
    final response =
    await http.get('http://192.168.1.3:8080/user/1');

    if (response.statusCode == 200) {
      // If server returns an OK response, parse the JSON.
      return User.fromJson(json.decode(response.body));

    } else {
      // If that response was not OK, throw an error.
      throw Exception('Failed to load post');
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: FutureBuilder<User>(
          future: fetchPost(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return Card(child:Column( children: <Widget>[Text(snapshot.data.firstName),
                Text(snapshot.data.lastName),
                Text(snapshot.data.email),
                Text(snapshot.data.mobile),],),);
            } else if (snapshot.hasError) {
              return Text("${snapshot.error}");
            }
            // By default, show a loading spinner.
            return CircularProgressIndicator();
          },
        ),
      ),
    );
  }

}