import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mhrms/config/Config.dart';
import 'package:mhrms/model/User.dart';
import 'package:mhrms/widgets/InputFormField.dart';

class CreateUser extends  StatefulWidget {
  CreateUser({Key key, this.user}) : super(key: key);
  final Future<User> user;
  @override
  _CreateUserState createState() => _CreateUserState();
}
class _CreateUserState extends State<CreateUser> {
  String uservalue="Status";
  String User_URL = Config.User_URL;
  TextEditingController firstnameController = new TextEditingController();
  TextEditingController lastnameController = new TextEditingController();
  TextEditingController emailController = new TextEditingController();
  TextEditingController mobileController = new TextEditingController();
  TextEditingController passwordController = new TextEditingController();

  void TextBoxClear(){
    firstnameController.clear();
    lastnameController.clear();
    emailController.clear();
    mobileController.clear();
    passwordController.clear();
  }

  Future<User> createUser(String url, {Map body}) async {
    http.Response response  = await http.post(Uri.encodeFull(url),
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json"
        },body: jsonEncode(body)
        ,encoding: Encoding.getByName("utf-8"));
    String currentStatus="";
    if(response.statusCode==200){
      currentStatus="Data Created at id"+response.body;
    }else {
      currentStatus="Data not created";
    }
    this.setState(() {
      uservalue = currentStatus;
    });
  }


  void createUserValue(){
    User newUser = new User(
        firstName:firstnameController.text,
        lastName: lastnameController.text,
        email: emailController.text,
        mobile: mobileController.text,
        password: passwordController.text
    );
    createUser(User_URL,body: newUser.toMap());


  }



  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: AppBar(
      title: Text("Upload Image Demo"),
    ),
          body: new Container(
            margin: const EdgeInsets.only(left: 8.0, right: 8.0),
            child: new Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
              InputFormField(label:"First Name",controller:firstnameController),
              InputFormField(label: "Last Name",controller:lastnameController),
              InputFormField(label: "E-MAIL",controller:emailController),
              InputFormField(label: "Mobile",controller:mobileController),
              InputFormField(label: "Password",controller:passwordController),
                new RaisedButton(
                  onPressed: createUserValue,
                  child: const Text("Create"),
                ),
                new RaisedButton(
                  onPressed: TextBoxClear,
                  child: const Text("Clear"),
                )
              ,Text(uservalue)],
            ),
          ),);

  }
}