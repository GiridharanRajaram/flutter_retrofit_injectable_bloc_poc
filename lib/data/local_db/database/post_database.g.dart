// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'post_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $PostDataBaseBuilderContract {
  /// Adds migrations to the builder.
  $PostDataBaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $PostDataBaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<PostDataBase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorPostDataBase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $PostDataBaseBuilderContract databaseBuilder(String name) =>
      _$PostDataBaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $PostDataBaseBuilderContract inMemoryDatabaseBuilder() =>
      _$PostDataBaseBuilder(null);
}

class _$PostDataBaseBuilder implements $PostDataBaseBuilderContract {
  _$PostDataBaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $PostDataBaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $PostDataBaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<PostDataBase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$PostDataBase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$PostDataBase extends PostDataBase {
  _$PostDataBase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  PostDao? _postDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `Post` (`id` INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, `title` TEXT NOT NULL, `body` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  PostDao get postDao {
    return _postDaoInstance ??= _$PostDao(database, changeListener);
  }
}

class _$PostDao extends PostDao {
  _$PostDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database, changeListener),
        _postInsertionAdapter = InsertionAdapter(
            database,
            'Post',
            (Post item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'body': item.body
                },
            changeListener);

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Post> _postInsertionAdapter;

  @override
  Stream<List<Post>> getAllPosts() {
    return _queryAdapter.queryListStream('SELECT * FROM Post',
        mapper: (Map<String, Object?> row) => Post(
            id: row['id'] as int,
            title: row['title'] as String,
            body: row['body'] as String),
        queryableName: 'Post',
        isView: false);
  }

  @override
  Future<void> delete(int id) async {
    await _queryAdapter
        .queryNoReturn('DELETE FROM Post WHERE id = ?1', arguments: [id]);
  }

  @override
  Future<void> insert(List<Post> posts) async {
    await _postInsertionAdapter.insertList(posts, OnConflictStrategy.replace);
  }
}
