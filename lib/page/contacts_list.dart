import 'package:flutter/cupertino.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';

class ContactsList extends StatefulWidget {
  const ContactsList({Key? key}) : super(key: key);

  @override
  _ContactsListState createState() => _ContactsListState();
}

class _ContactsListState extends State<ContactsList> {

  List<Contact> contacts = [];

  @override
  void initState() {
    super.initState();
    getAllContacts();
  }

  getAllContacts() async{
    List<Contact> _contacts = (await ContactsService.getContacts(withThumbnails: false)).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compartir')
      ),
      body: Container(
        padding: EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Text(
              ''
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: contacts.length,
              itemBuilder: (context, i){
                Contact contact = contacts[i];
                return ListTile(
                  title: Text(contact.displayName!),
                  subtitle: Text(contact.phones.elementAt(0).value!
                  ),
                  leading: (contact.avatar != null && contact.avatar!.length > 0) ?
                      CircleAvatar(
                        backgroundImage: MemoryImage(contact.avatar!),
                      ) :
                      CircleAvatar(
                        child: Text(contact.initials()),
                      )
                );
              }
            )
          ]
        )
      )
    );
  }
}
