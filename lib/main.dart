import 'package:flutter/material.dart';
import 'package:mhrms/screens/UploadImage.dart';
import 'package:mhrms/screens/UserList.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      //home: MyHomePage(title: 'Flutter Demo Home Page'),

      home: UploadImage(),

    );
  }
}
