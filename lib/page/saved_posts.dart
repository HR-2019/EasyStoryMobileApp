import 'package:easystoryapp/model/post.dart';
import 'package:easystoryapp/utils/database.dart';
import 'package:easystoryapp/utils/db_helper.dart';
import 'package:flutter/material.dart';
import 'package:easystoryapp/widget/item_card.dart';
import 'package:easystoryapp/utils/http_helper.dart';

import '../utils/config.dart' as config;

class SavedPosts extends StatefulWidget {

  @override
  _SavedPostsState createState() => _SavedPostsState();
}

class _SavedPostsState extends State<SavedPosts> {

  //DbHelper helper = DbHelper();
  List<Story> storiesList = [];
  //List<Post> postsList = [];

  int storiesCount = 0;

  @override
  void initState(){
    //initialize();
    //makeRequest();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    loadData();
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
                  itemCount: storiesCount,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 15.0,
                    crossAxisSpacing: 10.0,
                    childAspectRatio: 0.8,
                  ),
                  itemBuilder: (context,i) =>ItemCard(
                      Post("", "", storiesList[i].id, storiesList[i].userId, storiesList[i].title, storiesList[i].description, storiesList[i].content)
                  )

              )),
          SizedBox(height: 15.0)
        ],
      ),
    );
  }

  Future loadData() async{
    storiesList = await AppDatabase().getAllStory();

    //postsList = await helper.getPosts();

    setState(() {
      storiesCount = storiesList.length;
      storiesList = storiesList;
    });
  }

}

class PostDetails extends StatelessWidget {
  final index;
  PostDetails(this.index);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Detalles de publicación"),
      ),
      body: Center(
        child: Text(index['content']),
      ),

    );
  }
}