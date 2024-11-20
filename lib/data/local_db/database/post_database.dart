import 'dart:async';
import 'package:floor/floor.dart';
import 'package:flutter_retrofit_injectable_bloc_poc/data/local_db/dao/post_dao.dart';
import 'package:sqflite/sqflite.dart' as sqflite;
import '../../models/post_model.dart';

part 'post_database.g.dart';

@Database(version: 1, entities: [Post])
abstract class PostDataBase extends FloorDatabase {
  PostDao get postDao;
}
