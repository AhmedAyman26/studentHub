import 'package:graduation/features/posts/domain/models/post_model.dart';
import 'package:graduation/features/posts/domain/repository/post_repository.dart';

class GetPostsUseCase
{
  final PostRepository _postRepository;

  GetPostsUseCase(this._postRepository);
  Future<List<PostModel>> call()async
  {
    return await _postRepository.getPosts();
  }
}