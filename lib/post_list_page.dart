import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'config.dart' as config;

class MyPostList extends StatefulWidget {
  @override
  _MyPostListState createState() => _MyPostListState();
}

class _MyPostListState extends State<MyPostList> {
  List data = [];

  Future<String> makeRequest() async{

    String path = config.apiURL + "/api/users/1/posts";

    var response = await http.get(Uri.parse(path),
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'Authorization': 'Bearer ' + config.token});

    setState(() {
      var extractdata = json.decode(response.body);
      data = extractdata['content'];
      String info = data.toString();
      print('StatusCode: ' + response.statusCode.toString());
      print('data: ' + info);
    });

    //print(response.body);
    print('Title: ' + data[0]['title'].toString());
    print('Description: ' + data[0]["description"].toString());
    return response.body;
  }

  @override
  void initState(){
    this.makeRequest();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My posts"),
        ),
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, i){
              return ListTile(
                title: Text(data[i]["title"].toString()),
                subtitle: Text(data[i]["description"].toString()),
                /*leading: CircleAvatar(
                  backgroundImage:
                  NetworkImage((data[i]["picture"]["thumbnail"])),
                ),*/
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => PostDetails(data[i])));
                },
              );
            })
    );
  }
}

class PostDetails extends StatelessWidget {
  final index;
  PostDetails(this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My post details"),
      ),
      body: Center(
        child: Text(index['content']),
      ),

    );
  }
}