import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import 'post_list_page.dart';
import 'config.dart' as config;

class RegisterPage extends StatefulWidget {
  String token;
  RegisterPage(this.token);

  @override
  _RegisterPageState createState() => _RegisterPageState(token);
}

class _RegisterPageState extends State<RegisterPage> {

  String token;

  _RegisterPageState(this.token);

  var usernameController = TextEditingController();
  var passwordController = TextEditingController();
  var firstnameController = TextEditingController();
  var lastnameController = TextEditingController();
  var emailController = TextEditingController();
  var telephoneController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
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
                        height: 15,
                      ),
                      TextFormField(
                        controller: firstnameController,
                        decoration: InputDecoration(
                            labelText: "Firstname",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.login)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: lastnameController,
                        decoration: InputDecoration(
                            labelText: "Lastname",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.login)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: emailController,
                        decoration: InputDecoration(
                            labelText: "Email",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.login)),
                      ),
                      SizedBox(
                        height: 15,
                      ),
                      TextFormField(
                        controller: telephoneController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                            labelText: "Telephone",
                            border: OutlineInputBorder(),
                            suffixIcon: Icon(Icons.login)),
                      ),
                      SizedBox(
                        height: 45,
                      ),
                      OutlinedButton.icon(
                          onPressed: () {
                            register();
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

  Future<void> register() async{
    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty
    && firstnameController.text.isNotEmpty && lastnameController.text.isNotEmpty
    && emailController.text.isNotEmpty && telephoneController.text.isNotEmpty){

      Map data = {
        'username': usernameController.text,
        'password': passwordController.text,
        'firstName': firstnameController.text,
        'lastName': lastnameController.text,
        'email': emailController.text,
        'telephone': telephoneController.text
      };

      var body = json.encode(data);

      var response = await http.post(Uri.parse(config.apiURL + "/api/users/"),
          body: body, headers: {"Content-Type": "application/json"},);

      var json_decode = json.decode(response.body);
      String info = json_decode.toString();
      print('StatusCode: ' + response.statusCode.toString());
      print('data: ' + info);

      if (response.statusCode == 200){
        /*Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyPostList(token)));*/
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Ocurrió un problema. Inténtalo nuevamente")));
      }

      print('StatusCode: ' + response.statusCode.toString());

    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Algún campo está vacío")));
    }

  }

}