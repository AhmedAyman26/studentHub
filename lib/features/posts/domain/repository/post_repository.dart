
import 'package:graduation/features/posts/domain/models/create_post_input.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';

abstract class PostRepository
{
  Future<List<PostModel>> getPosts();
  Future<void> addPost(CreatePostInput input);
}