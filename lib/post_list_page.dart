import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:easystoryapp/widget/item_card.dart';

import 'config.dart' as config;

class MyPostList extends StatefulWidget {
  String token;
  Map userData;
  MyPostList(this.token, this.userData);

  @override
  _MyPostListState createState() => _MyPostListState(token, userData);
}

class _MyPostListState extends State<MyPostList> {
  List data = [];
  String token;
  Map userData;

  _MyPostListState(this.token, this.userData);

  Future<String> makeRequest() async{

    String path = config.apiURL + "/api/users/1/posts";

    var response = await http.get(Uri.parse(path),
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'Authorization': 'Bearer ' + token});

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

  Future<void> getTokenFromPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? 'Invalid token';
  }

  @override
  void initState(){
    getTokenFromPrefs();
    print('post_list_page: ' + token);
    makeRequest();
  }

  /*@override
  Widget build(BuildContext context) {
    return Scaffold(
        body: ListView.builder(
            itemCount: data == null ? 0 : data.length,
            itemBuilder: (BuildContext context, i){
              return ListTile(
                title: Text(data[i]["title"].toString()),
                subtitle: Text(data[i]["description"].toString()),
                onTap: (){
                  Navigator.push(
                      context,
                      MaterialPageRoute(builder: (BuildContext context) => PostDetails(data[i])));
                },
              );
            })
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 30.0,
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 50.0,
              child: GridView.builder(
                  itemCount: data.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context,i) =>ItemCard(
                      data[i]['title'], data[i]['description'], data[i]['content']
                  )

              )),
          SizedBox(height: 15.0)
        ],
      ),
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