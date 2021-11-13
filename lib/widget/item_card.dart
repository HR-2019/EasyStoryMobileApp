import 'package:easystoryapp/model/post.dart';
import 'package:easystoryapp/page/post_detail.dart';
import 'package:flutter/material.dart';

class ItemCard extends StatelessWidget {
  final Post post;

  const ItemCard({Key? key, required this.post}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: EdgeInsets.only(top: 5.0, bottom: 35.0, left: 15.0, right: 15.0),
        child: InkWell(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => PostDetail(
                    image: post.image,
                    title: post.title,
                    content: post.content,
                    userId: post.userId,
                  )));
            },
            child: Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    boxShadow: [
                      BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 3.0,
                          blurRadius: 5.0)
                    ],
                    color: Colors.white),
                child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Center(
                        child: Text(post.title,
                          style: TextStyle(
                              color: Color(0xFF575E67),
                              fontFamily: 'Varela',
                              fontSize: 16.0),
                          textAlign: TextAlign.center,),
                      ),
                      Expanded(child: Container(
                        child: Hero(
                          tag: post.title,
                          child: Image.network(post.image),
                        ),
                      )),
                      Center(
                        child: Text(post.description,
                          style: TextStyle(
                              color: Color(0xFF575E67),
                              fontFamily: 'Varela',
                              fontSize: 12.0),
                          textAlign: TextAlign.center,),
                      ),


                    ]))));
  }
}