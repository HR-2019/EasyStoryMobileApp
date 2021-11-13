import 'dart:collection';

import 'package:easystoryapp/page/home_page.dart';
import 'package:easystoryapp/page/profile_page.dart';
import 'package:easystoryapp/register_page.dart';
import 'package:easystoryapp/post_list_page.dart';
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
      home: HomePage(),
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
                    Image.asset('images/easylogo.png'),
                    SizedBox(
                      height: 60,
                    ),
                    TextFormField(
                      controller: usernameController,
                      decoration: InputDecoration(
                          labelText: "Username",
                          border: OutlineInputBorder(),
                          suffixIcon: Icon(Icons.login)),
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
                          suffixIcon: Icon(Icons.password)),
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
                    SizedBox(
                      height: 15,
                    ),
                    OutlinedButton.icon(
                        onPressed: () {
                          Navigator.push(
                              context, MaterialPageRoute(builder: (context) => ProfileWriterPage()));
                        },
                        icon: Icon(
                          Icons.app_registration,
                          size: 18,
                        ),
                        label: Text("Register")),
                  ],))),
      )
    );
  }

  Future<void> login() async{
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var response = await http.get(Uri.parse(config.apiURL + "/api/users/findbyusername/" + usernameController.text),
          headers: {'Content-Type': 'application/json', 'accept': '*/*', 'Authorization': 'Bearer ' + config.token});

      var data = json.decode(response.body);
      String info = data.toString();
      print('StatusCode: ' + response.statusCode.toString());
      print('data: ' + info);

      if (response.statusCode == 200){
        String password = json.decode(response.body)["password"].toString();
        if (passwordController.text == password) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyPostList()));
        } else {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("La contraseña es incorrecta")));
        }
      } else if (response.statusCode == 404){
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("La cuenta no existe")));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ocurrió un problema. Inténtalo nuevamente")));
      }

      print('StatusCode: ' + response.statusCode.toString());

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Algún campo está vacío")));
    }

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

}



