import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mhrms/model/User.dart';
import 'package:mhrms/widgets/InputFormField.dart';
import 'package:http/http.dart' as http;



class CreateUser extends StatefulWidget {




  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  String _status = "";
  void _statusCreate() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _status=firstnameController.text+lastnameController.text+emailController.text+mobileController.text+passwordController.text;
    });
  }
  Future<User> createUser(String url, {Map body}) async {
    return http.post(url, body: body).then((http.Response response) {
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return User.fromJson(json.decode(response.body));
    });
  }

TextEditingController firstnameController = new TextEditingController();
TextEditingController lastnameController = new TextEditingController();
TextEditingController emailController = new TextEditingController();
TextEditingController mobileController = new TextEditingController();
TextEditingController passwordController = new TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create User"),
      ),
      body:Form(child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[InputFormField(label:"First Name",controller:firstnameController),
                           InputFormField(label: "Last Name",controller:lastnameController),
                           InputFormField(label: "E-MAIL",controller:emailController),
                           InputFormField(label: "Mobile",controller:mobileController),
                           InputFormField(label: "Password",controller:passwordController),
                           RaisedButton.icon(onPressed: _statusCreate/*() async {
                             User newUser =
                             new User(
                                 firstName:firstnameController.text,
                                 lastName: lastnameController.text,
                                 email: emailController.text,
                                 mobile: mobileController.text,
                                 password: passwordController.text
                             );
                             User p = await createUser("http://192.168.1.3:8080/user",body: newUser.toMap());

                           }*/,
                             icon: Icon(Icons.add),
                             label: Text("User"),),
                           Text(_status)

        ],)),
    );
  }
}