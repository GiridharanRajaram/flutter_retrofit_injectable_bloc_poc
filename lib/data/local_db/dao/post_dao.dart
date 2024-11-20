import 'package:floor/floor.dart';
import '../../models/post_model.dart';

@dao
abstract class PostDao {
  @Query('SELECT * FROM Post')
  Stream<List<Post>> getAllPosts();

  @Insert(onConflict: OnConflictStrategy.replace)
  Future<void> insert(List<Post> posts);

  @Query('DELETE FROM Post WHERE id = :id')
  Future<void> delete(int id);
}
