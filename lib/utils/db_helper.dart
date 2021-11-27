import 'package:easystoryapp/model/post.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper{

  final int version = 1;
  Database? db;

  static final DbHelper _dbHelper = DbHelper._internal();

  DbHelper._internal();

  factory DbHelper() {
    return _dbHelper;
  }

  Future<Database> openDb() async {
    if (db == null) {
      db = await openDatabase(join(await getDatabasesPath(), 'easystoryapp.db'),
          onCreate: (db, version) {
            db.execute(
                'CREATE TABLE posts(id INTEGER PRIMARY KEY, userId INTEGER, title TEXT, description TEXT, content TEXT)');
          }, version: version);
    }
    return db!;
  }

  Future<int> insertPost(Post post) async {
    int id = await db!.insert('posts', post.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);//opcional
    return id;
  }

  Future<bool> isFavorite(Post post) async {
    final List<Map<String, dynamic>> maps = await db!.query('posts', where: 'id = ?', whereArgs: [post.id]);
    print(maps.length);
    return maps.length > 0;
  }

  Future<int> deletePost(Post post) async {
    int result = await db!.delete('posts', where: 'id = ?', whereArgs: [post.id]);
    return result;
  }

  Future<List<Post>> getPosts() async{
    final List<Map<String, dynamic>> maps = await db!.query('posts');

    return List.generate(maps.length, (i) {
      return Post(
        maps[i]['createdAt'],
        maps[i]['updatedAt'],
        maps[i]['id'],
        maps[i]['userId'],
        maps[i]['title'],
        maps[i]['description'],
        maps[i]['content']
      );
    });
  }

}