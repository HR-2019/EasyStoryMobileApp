import 'package:moor_flutter/moor_flutter.dart';
part 'database.g.dart';

class Stories extends Table{
  IntColumn get id => integer()();
  IntColumn get userId => integer()();
  TextColumn get title => text()();
  TextColumn get description => text()();
  TextColumn get content => text()();
}

@UseMoor(tables: [Stories])
class AppDatabase extends _$AppDatabase{
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(path: "easystory.sqlite",
      logStatements: true));

  int get schemaVersion => 1;

  Future<List<Story>> getAllStory() => select(stories).get();
  Stream<List<Story>> watchAllStory() => select(stories).watch();

  Future insertNewStory(Story story) => into(stories).insert(story);

  Future updateStory(Story story) => update(stories).replace(story);

  Future deleteStory(Story story) => delete(stories).delete(story);

}