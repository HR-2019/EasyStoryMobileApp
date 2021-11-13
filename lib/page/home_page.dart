import 'package:easystoryapp/model/post.dart';
import 'package:easystoryapp/widget/item_card.dart';
import 'package:flutter/material.dart';

class HomePage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFCFAF8),
      body: ListView(
        children: <Widget>[
          SizedBox(height: 15.0),
          Container(
              padding: EdgeInsets.only(right: 15.0),
              width: MediaQuery
                  .of(context)
                  .size
                  .width - 30.0,
              height: MediaQuery
                  .of(context)
                  .size
                  .height - 50.0,
              child: GridView.builder(
                  itemCount: posts.length,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context,index) =>ItemCard(
                      post: posts[index]
                  )

              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }
}