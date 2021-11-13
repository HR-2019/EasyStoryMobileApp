import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        /*appBar: AppBar(
          title: Text("My posts"),
        ),*/
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

// class EditPost extends StatelessWidget {
//   final index;
//   EditPost(this.index);
//
//   var titleController = TextEditingController();
//   var descriptionController = TextEditingController();
//   var contentController = TextEditingController();
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text("Edit Post"),
//       ),
//         body: Padding(
//           padding: const EdgeInsets.all(10.0),
//           child: SafeArea(
//               child: Center(
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       TextFormField(
//                         controller: titleController,
//                         decoration: InputDecoration(
//                             labelText: "Title",
//                             border: OutlineInputBorder(),
//                             suffixIcon: Icon(Icons.login)),
//                         initialValue: index['title'],
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       TextFormField(
//                         controller: descriptionController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                             labelText: "Description",
//                             border: OutlineInputBorder(),
//                             suffixIcon: Icon(Icons.password)),
//                         initialValue: index['description'],
//                       ),
//                       SizedBox(
//                         height: 15,
//                       ),
//                       TextFormField(
//                         controller: contentController,
//                         obscureText: true,
//                         decoration: InputDecoration(
//                             labelText: "Content",
//                             border: OutlineInputBorder(),
//                             suffixIcon: Icon(Icons.password)),
//                         initialValue: index['content'],
//                       ),
//                       SizedBox(
//                         height: 45,
//                       ),
//                       OutlinedButton.icon(
//                           onPressed: () {
//                             edit();
//                           },
//                           icon: Icon(
//                             Icons.login,
//                             size: 18,
//                           ),
//                           label: Text("Edit")),
//                     ],))),
//         ),
//
//     );
//   }
//
//   Future<void> edit() async{
//     if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && contentController.text.isNotEmpty){
//
//       Map data = {
//         'title': titleController.text,
//         'description': descriptionController.text,
//         'content': contentController.text
//       };
//
//       var body = json.encode(data);
//
//       var response = await http.post(Uri.parse(config.apiURL + "/api/users/"),
//           body: body,
//           headers: {'Content-Type': 'application/json', 'accept': '*/*', 'Authorization': 'Bearer ' + config.token});
//
//       var json_decode = json.decode(response.body);
//       String info = json_decode.toString();
//       print('StatusCode: ' + response.statusCode.toString());
//       print('data: ' + info);
//
//       if (response.statusCode == 200){
//         //Navigator.of(context).pop();
//         //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Se actualizó correctamente")));
//       } else {
//         //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ocurrió un problema. Inténtalo nuevamente")));
//       }
//
//       print('StatusCode: ' + response.statusCode.toString());
//
//     } else {
//       //ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Algún campo está vacío")));
//     }
//
//   }
//
// }