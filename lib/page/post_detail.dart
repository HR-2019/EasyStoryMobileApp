import 'package:easystoryapp/model/post.dart';
import 'package:easystoryapp/model/post.dart';
import 'package:easystoryapp/page/profile.dart';
import 'package:easystoryapp/utils/database.dart';
import 'package:easystoryapp/utils/db_helper.dart';
import 'package:flutter/material.dart';

class PostDetail extends StatelessWidget {
  //final image, id, userId, title, description, content;
  DbHelper helper = DbHelper();
  String image;
  Post post;

  PostDetail(this.image, this.post);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0.0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: Color(0xFF545D68)),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        title: Text('Publicación',
            style: TextStyle(
                fontFamily: 'Varela',
                fontSize: 20.0,
                color: Color(0xFF545D68))),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.favorite, color: Color(0xFF545D68)),
            onPressed: () {
              //helper.insertPost(post);
              AppDatabase().insertNewStory(Story(id: post.id, userId: post.userId, title: post.title, description: post.description, content: post.content));
            },
          ),
        ],
      ),

      body: ListView(
          children: [
            SizedBox(height: 15.0),
            Padding(
                padding: EdgeInsets.only(left: 20.0),
                child: Row(
                  children: <Widget>[
                    Text(
                        'EasyStory',
                        style: TextStyle(
                            fontFamily: 'Varela',
                            fontSize: 42.0,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFFF17532))
                    ),
                    Padding(padding: EdgeInsets.only(left: 90.0)),
                    buildImage(context)

                  ],
                )

            ),
            SizedBox(height: 15.0),
            Hero(
                tag: "image",
                child: Image.network(image,
                    height: 150.0,
                    width: 100.0,
                    fit: BoxFit.contain
                )
            ),

            SizedBox(height: 10.0),
            Center(
              child: Text(post.title,
                  style: TextStyle(
                      color: Color(0xFF575E67),
                      fontFamily: 'Varela',
                      fontSize: 24.0)),
            ),
            SizedBox(height: 20.0),
            Center(
              child: Container(
                width: MediaQuery.of(context).size.width - 50.0,
                child: Text(post.content,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'Varela',
                        fontSize: 16.0,
                        color: Color(0xFFB4B8B9))
                ),
              ),
            ),
            SizedBox(height: 20.0),

          ]
      ),
    );
  }

  Widget buildImage(BuildContext context) {
    final image = NetworkImage("https://www.hola.com/imagenes/actualidad/20180621126047/mario-vargas-llosa-comunicado/0-578-592/mario-vargasllosa1-t.jpg?filter=w600");

    return ClipOval(
      child: Material(
        color: Colors.transparent,
        child: Ink.image(
          image: image,
          fit: BoxFit.cover,
          width: 60,
          height: 60,
          child: InkWell(onTap: (){
            Navigator.of(context).push(
                MaterialPageRoute(builder: (context) =>
                    Profile()));
          }),
        ),
      ),
    );
  }
}