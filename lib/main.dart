import 'dart:collection';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'config.dart' as config;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
    );
  }
}

class LoginPage extends StatefulWidget {

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.email)),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: passwordController,
                      obscureText: true,
                      decoration: InputDecoration(
                          labelText: "Password",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.email)),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    OutlinedButton.icon(
                        onPressed: () {
                          login();
                        },
                        icon: Icon(
                          Icons.login,
                          size: 18,
                        ),
                        label: Text("Login")),
                  ],))),
      )
    );
  }

  Future<void> login() async{
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var response = await http.get(Uri.parse(config.apiURL + "/api/users/findbyusername/" + usernameController.text),
          headers: {'Content-Type': 'application/json', 'accept': '*/*', 'Authorization': 'Bearer ' + config.token});

      print(response.body.toString());

      if (response.statusCode == 200){
        Navigator.push(context, MaterialPageRoute(builder: (context)=>MyPostList()));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("La contraseña es incorrecta")));
      }

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Algún campo está vacío")));
    }

  }

}


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

  Future<String> getToken() async {
    final response = await http.post(
      Uri.parse(config.apiURL + '/api/auth/sign-in'),
      headers: <String, String>{
        'Content-Type': 'application/json', 'accept': '*/*',
      },
      body: jsonEncode(<String, String>{
        'username': "admin",
        'password': "admin",
      }),
    );

    if (response.statusCode == 200) {
      var dataf = jsonDecode(response.body);
      String info = dataf.toString();
      print('StatusCode: ' + response.statusCode.toString());
      print('data: ' + info);
      print('token: ' + dataf['token']);
      return response.body;

    } else {
      throw Exception('Failed to get token.');
    }
  }

  @override
  void initState(){
    //this.getToken();
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
