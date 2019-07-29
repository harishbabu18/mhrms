import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mhrms/config/Config.dart';

import 'UploadImage.dart';
import 'UserDetails.dart';

class UserList extends StatefulWidget {
  @override
  UserListPageState createState() => new UserListPageState();
}

class UserListPageState extends State<UserList> {

  ScrollController _scrollController = new ScrollController();
  int pageNo=0;
  int totalpages=0;
  int pageSize=10;
  String sortBy="";
  String User_URL = Config.User_URL;
  var userDTO;
  List data;
  Future<String> getData() async {
    var response = await http.get(
        Uri.encodeFull(User_URL+"?pageNo="+pageNo.toString()+"&?pageSize="+pageSize.toString()+"&?sortBy="+sortBy),
        headers: {
          "Accept": "application/json"
        }
    );



    this.setState(() {
      userDTO=json.decode(response.body);
      data=userDTO["users"];
      totalpages=userDTO["pages"];
    });
    return "Success!";
  }
  Future<String> loadData(int ipageNo) async {
    var response = await http.get(
        Uri.encodeFull(User_URL+"?pageNo="+ipageNo.toString()+"&?pageSize="+pageSize.toString()+"&?sortBy="+sortBy),
        headers: {
          "Accept": "application/json"
        }
    );



    this.setState(() {
      userDTO=json.decode(response.body);
      data=userDTO["users"];
    });
    return "Success!";
  }
  void nextPage(){
    if(pageNo<userDTO["pages"]-1) {
      this.setState(() {
        pageNo = pageNo + 1;
      });
      loadData(pageNo);
      print(pageNo);
    }
  }
  void previosPage(){
    if(pageNo>0){
    this.setState((){pageNo=pageNo-1;});
    loadData(pageNo);
    print(pageNo);
    }
  }

  @override
  void initState(){
    super.initState();
    this.getData();
  }

  Future<Null> refreshlist() async{
    await Future.delayed(Duration(seconds: 1));
    setState(() {
      this.getData();
    });
    print("Referesh Data Hapened");
    return null;
  }

  @override
  Widget build(BuildContext context){
    return new Scaffold(
      appBar: AppBar(
        title: Text("User Details-Page-"+(pageNo+1).toString()+"/"+totalpages.toString()),
          actions: <Widget>[
            IconButton(icon: Icon(Icons.arrow_left),onPressed: previosPage,),
            IconButton(icon: Icon(Icons.search),onPressed: previosPage,),
            IconButton(icon: Icon(Icons.arrow_right),onPressed: nextPage,)
          ]

      ),
      body: RefreshIndicator(child: new ListView.builder(
        controller: _scrollController,
        itemCount: data == null ? 0 : data.length,
        itemBuilder: (BuildContext context, int index){
          return _listItem(index);
        },
      ),
           onRefresh: refreshlist),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => UploadImage()),
          );

        },
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }

  _searchBar(){
    return Padding(padding: const EdgeInsets.all(8.0),
      child: TextField(
        decoration: InputDecoration(hintText: "Search .."),
        onChanged: (text){


        },
      ),
    );
  }


  _listItem(index){
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
