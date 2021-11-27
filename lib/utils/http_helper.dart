import 'package:http/http.dart' as http;
import 'dart:io';
import 'dart:convert';
import 'package:easystoryapp/model/post.dart';
import 'package:easystoryapp/utils/config.dart' as config;

class HttpHelper{

  final String urlBackend = config.apiURL;

  Future<List> getPostsList() async{

    String path = config.apiURL + "/api/users/1/posts";

    var response = await http.get(Uri.parse(path),
        headers: {'Content-Type': 'application/json', 'accept': '*/*', 'Authorization': 'Bearer ' + config.token});

    print('StatusCode: ' + response.statusCode.toString());
    if (response.statusCode == HttpStatus.ok){
      final jsonResponse = json.decode(response.body);
      final postsMap = jsonResponse['content'];
      String info = postsMap.toString();
      print('data: ' + info);
      List posts = postsMap.map((i) => Post.fromJson(i)).toList();
      //print('data of post list: ' + posts.toString());
      return posts;
    } else {
      return null!;
    }

    /*var extractdata = json.decode(response.body);
    data = extractdata['content'];
    String info = data.toString();
    print('StatusCode: ' + response.statusCode.toString());
    print('data: ' + info);

    //print(response.body);
    print('Title: ' + data[0]['title'].toString());
    print('Description: ' + data[0]["description"].toString());
    return response.body;*/
  }

  Future<bool> registerAPost(Post post) async {

    String path = config.apiURL + "/api/users/1/posts";
    var response = await http.post(Uri.parse(path), headers: <String, String>{
      'Content-Type': 'application/json; charset=UTF-8',
    },
      body: jsonEncode(<String, String>{
        'title': post.title,
        'description': post.description,
        'content': post.content,
      })
    );

    if (response.statusCode == HttpStatus.ok){

      final jsonResponse = json.decode(response.body);
      String info = jsonResponse.toString();
      print('dataPost: ' + info);
      return true;
    } else {
      return false;
    }

  }

}