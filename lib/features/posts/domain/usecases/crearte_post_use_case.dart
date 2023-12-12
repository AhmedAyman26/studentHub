import 'package:graduation/features/posts/domain/models/create_post_input.dart';
import 'package:graduation/features/posts/domain/repository/post_repository.dart';

class CreatePostUseCase
{
  final PostRepository _postRepository;

  CreatePostUseCase(this._postRepository);

  Future<void> call(CreatePostInput input)async
  {
    return await _postRepository.addPost(input);
  }
}