//import 'package:easystoryapp/page/edit_profile.dart';
import 'package:easystoryapp/widget/button_widget.dart';
import 'package:easystoryapp/widget/numbers_widget.dart';
import 'package:easystoryapp/widget/profile_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:easystoryapp/preferences.dart';

class ProfilePage extends StatefulWidget {
  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {

  Map userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preferences.init();
    userData['firstName'] = preferences.getFirstName();
    userData['lastName'] = preferences.getLastName();
    userData['username'] = preferences.getUsername();
    userData['email'] = preferences.getEmail();
    userData['subscribers'] = preferences.getSubscribers();
    userData['subscriptions'] = preferences.getSubscriptions();
    //getUserData();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          ProfileWidget(
            imagePath: 'https://cdn4.iconfinder.com/data/icons/political-elections/50/48-512.png',
            onClicked: () {
              /*Navigator.of(context).push(
                MaterialPageRoute(builder: (context) => EditProfilePage()),
              );*/
            },
          ),
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          NumbersWidget(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
    children: [
      Text(
        userData['firstName'],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        userData['email'],
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Upgrade To PRO',
    onClicked: () {},
  );

  Widget buildAbout() => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Texto para el about',
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}

class ProfileWriterPage extends StatefulWidget {

  @override
  _ProfileWriterPageState createState() => _ProfileWriterPageState();
}

class _ProfileWriterPageState extends State<ProfileWriterPage> {

  Map userData = {};

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    preferences.init();
    userData['firstName'] = preferences.getFirstName();
    userData['lastName'] = preferences.getLastName();
    userData['username'] = preferences.getUsername();
    userData['email'] = preferences.getEmail();
    userData['subscribers'] = preferences.getSubscribers();
    userData['subscriptions'] = preferences.getSubscriptions();
    //getUserData();
  }

  @override
  Widget build(BuildContext context) {
    String title = "Editar Perfil Escritor";

    return Scaffold(
      body: ListView(
        physics: BouncingScrollPhysics(),
        children: [
          /*ProfileWriterWidget(
            imagePath: user.imagePath,
            onClicked: () {
            },
          ),*/
          const SizedBox(height: 24),
          buildName(),
          const SizedBox(height: 24),
          Center(child: buildUpgradeButton()),
          const SizedBox(height: 24),
          NumbersWidget(),
          const SizedBox(height: 48),
          buildAbout(),
        ],
      ),
    );
  }

  Widget buildName() => Column(
    children: [
      Text(
        userData['firstName'],
        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
      ),
      const SizedBox(height: 4),
      Text(
        userData['email'],
        style: TextStyle(color: Colors.grey),
      )
    ],
  );

  Widget buildUpgradeButton() => ButtonWidget(
    text: 'Suscribirse',
    onClicked: () {},
  );

  Widget buildAbout() => Container(
    padding: EdgeInsets.symmetric(horizontal: 48),
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About',
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        Text(
          'Mensaje de about... profilewriterpage',
          style: TextStyle(fontSize: 16, height: 1.4),
        ),
      ],
    ),
  );
}