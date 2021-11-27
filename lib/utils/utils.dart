import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

String capitalize(String s) => s[0].toUpperCase() + s.substring(1);

void _showNewVersionAvailableDialog(BuildContext context) {
  final alert = AlertDialog(
    title: Text("Error"),
    content: Text("There was an error during login."),
    actions: [FlatButton(child: Text("OK"), onPressed: () {})],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}