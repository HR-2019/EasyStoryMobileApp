import 'dart:collection';

import 'package:easystoryapp/page/contacts_list.dart';
import 'package:easystoryapp/page/profile.dart';
import 'package:easystoryapp/page/register_post.dart';
import 'package:easystoryapp/page/saved_posts.dart';
import 'package:easystoryapp/utils/preferences.dart';
import 'package:easystoryapp/page/register.dart';
import 'package:easystoryapp/page/post_list.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'utils/config.dart' as config;
import 'package:shared_preferences/shared_preferences.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await preferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: LoginPage(),
        theme: ThemeData(
            primaryColor: Color(0xFF2F008E),
            accentColor: Color(0xFFFDD303)
        )
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
  String token = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getTokenFromAPI();
    //getTokenFromPrefs();
    token = preferences.getToken();
  }

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
                              context, MaterialPageRoute(builder: (context) => Register(token)));
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

    print('El token al iniciar eeeees: ' + token);

    if (usernameController.text.isNotEmpty && passwordController.text.isNotEmpty){
      var response = await http.get(Uri.parse(config.apiURL + "/api/users/findbyusername/" + usernameController.text),
          headers: {'Content-Type': 'application/json', 'accept': '*/*', 'Authorization': 'Bearer ' + token});

      var userData = json.decode(response.body);
      String info = userData.toString();
      print('StatusCode: ' + response.statusCode.toString());
      print('data: ' + info);

      if (response.statusCode == 200){
        String password = json.decode(response.body)["password"].toString();
        if (passwordController.text == password) {
          /*Navigator.push(
              context, MaterialPageRoute(builder: (context) => MyPostList()));*/
            await preferences.setUserId(userData['id']);
            await preferences.setUsername(userData['username']);
            await preferences.setFirstName(userData['firstName']);
            await preferences.setLastName(userData['lastName']);
            await preferences.setEmail(userData['email']);
            await preferences.setTelephone(userData['telephone']);
            await preferences.setSubscribers(userData['subscribers']);
            await preferences.setSubscriptions(userData['subscriptions']);

          Navigator.push(
              context, MaterialPageRoute(builder: (context) => Home(token)));
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

  Future<String> getTokenFromAPI() async {

    //final SharedPreferences prefs = await SharedPreferences.getInstance();

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
      await preferences.setToken(dataf['token']);
      //return prefs.getString("token") ?? 'Invalid token';
      return response.body;

    } else {
      throw Exception('Failed to get token.');
    }
  }

  /*Future<void> getTokenFromPrefs() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    token = prefs.getString("token") ?? 'Invalid token';
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("¡Bienvenido!")));
  }*/

  /*Future<void> saveUserData(userData) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('userId', userData['id']);
    prefs.setString('username', userData['username']);
    prefs.setString('firstName', userData['firstName']);
    prefs.setString('lastName', userData['lastName']);
    prefs.setString('email', userData['email']);
    prefs.setString('telephone', userData['telephone']);
    prefs.setInt('subscribers', userData['subscribers']);
    prefs.setInt('subscriptions', userData['subscriptions']);
  }*/

}

/*class Home extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Navigation drawer',
      home: MyPostList(),
      theme: ThemeData(
        primaryColor: Color(0xFF2F008E),
        accentColor: Color(0xFFFDD303)
      )
    );
  }
}*/

class Home extends StatefulWidget{
  String token;
  Home(this.token);

  HomeState createState() => HomeState(token);

}

class HomeState extends State<Home>{
  int _selectDrawerItem = 0;
  String token;
  Map userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    userData['username'] = preferences.getUsername();
    userData['email'] = preferences.getEmail();
    //getUserData();
  }

  HomeState(this.token);
  _getDrawerItemWidget(int pos){
    switch(pos){
      case 0: return PostList(token, userData);
      case 1: return ContactsList();
      case 4: return Profile();
    }
  }

  _onSelectItem(int pos){
    Navigator.of(context).pop();
    setState(() {
      _selectDrawerItem = pos;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('EasyStoryApp'), actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.push(
                    context, MaterialPageRoute(builder: (context) => RegisterPost()));
              },
            ),
          ]),
      drawer: Drawer(
          child: ListView(
              children: <Widget>[
                UserAccountsDrawerHeader(
                  accountName: Text(userData['username']),
                  accountEmail: Text(userData['email']),
                  currentAccountPicture: CircleAvatar(
                      backgroundColor: Colors.blue,
                      child: Text(
                          userData['username'][0],
                          style: TextStyle(fontSize: 40.0)
                      )
                  ),
                ),
                ListTile(
                    title: Text('Mis publicaciones'),
                    leading: Icon(Icons.list),
                    selected: (0 == _selectDrawerItem),
                    onTap: (){
                      _onSelectItem(0);
                    }
                ),
                ListTile(
                    title: Text('Publicaciones guardadas'),
                    leading: Icon(Icons.list_alt_sharp),
                    selected: (1 == _selectDrawerItem),
                    onTap: (){
                      _onSelectItem(1);
                    }
                ),
                ListTile(
                    title: Text('Mis hashtags'),
                    leading: Icon(Icons.format_list_numbered),
                    selected: (2 == _selectDrawerItem),
                    onTap: (){
                      //_onSelectItem(1);
                    }
                ),
                ListTile(
                    title: Text('Pagos'),
                    leading: Icon(Icons.payment),
                    selected: (3 == _selectDrawerItem),
                    onTap: (){
                      //_onSelectItem(1);
                    }
                ),
                Divider(),
                ListTile(
                    title: Text('Mi perfil'),
                    leading: Icon(Icons.person),
                    selected: (4 == _selectDrawerItem),
                    onTap: (){
                      _onSelectItem(4);
                    }
                ),
                ListTile(
                    title: Text('Salir'),
                    leading: Icon(Icons.logout),
                    onTap: (){
                      //_onSelectItem(1);
                    }
                )
              ]
          )
      ),
      body: _getDrawerItemWidget(_selectDrawerItem)
    );
  }

  /*Future<void> getUserData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userData['userId'] = prefs.getInt('userId') ?? 1;
    userData['username'] = prefs.getString('username') ?? 'No username';
    userData['firstName'] = prefs.getString('firstName') ?? 'Primer nombre';
    userData['lastName'] = prefs.getString('lastName') ?? 'Apellido';
    userData['email'] = prefs.getString('email') ?? 'Email';
    userData['telephone'] = prefs.getString('telephone') ?? 'Telefono';
    userData['subscribers'] = prefs.getInt('subscribers') ?? 'Suscriptores';
    userData['subscriptions'] = prefs.getInt('subscriptions') ?? 'Suscripciones';
    print(userData);
  }*/

}