import 'package:easystoryapp/model/post.dart';
import 'package:easystoryapp/utils/http_helper.dart';
import 'package:easystoryapp/widget/appbar_widget.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class RegisterPost extends StatefulWidget {

  @override
  _RegisterPost createState() => _RegisterPost();

}

class _RegisterPost extends State<RegisterPost> {

  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  var contentController = TextEditingController();

  late bool result;
  late HttpHelper helper;

  @override
  void initState(){
    helper = HttpHelper();
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: buildAppBar(context, "Registrar una publicación"),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: SafeArea(
            child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Datos de la historia', style: TextStyle(fontSize: 25),),
                    SizedBox(
                      height: 80,
                    ),
                    TextFormField(
                      controller: titleController,
                      decoration: InputDecoration(
                          labelText: "Título",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: descriptionController,
                      decoration: InputDecoration(
                          labelText: "Descripción",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    TextFormField(
                      controller: contentController,
                      decoration: InputDecoration(
                          labelText: "Contenido",
                          border: OutlineInputBorder()),
                    ),
                    SizedBox(
                      height: 45,
                    ),
                    OutlinedButton.icon(
                        onPressed: () {
                          RegisterAPost();
                        },
                        icon: Icon(
                          Icons.app_registration,
                          size: 18,
                        ),
                        label: Text("Publicar")),
                  ],))),
      )
    );

  }

  Future<void> RegisterAPost() async{

    if (titleController.text.isNotEmpty && descriptionController.text.isNotEmpty && contentController.text.isNotEmpty){

      Post newPost = Post("", "", 0, 0, titleController.text, descriptionController.text, contentController.text);
       result = await helper.registerAPost(newPost);

       if (result){
         _showDialog(context, true);
       } else {
         _showDialog(context, false);
       }

    }

  }

  void _showDialog(BuildContext context, bool isOk) {
    String message;

    if (!isOk){
      message = "Ocurrió un problema durante la publicación. Inténtelo nuevamente.";
    } else {
      message = "Se logró publicar la historia";
    }

    final alert = AlertDialog(
      title: Text("Mensaje"),
      content: Text(message),
      actions: [FlatButton(child: Text("OK"), onPressed: () {
        Navigator.pop(context);
      })],
    );

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }

}

