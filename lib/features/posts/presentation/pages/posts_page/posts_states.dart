import 'package:equatable/equatable.dart';
import 'package:graduation/common/utils/utils.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';

class PostStates extends Equatable {
  final RequestStatus getPostState;
  final List<PostModel> posts;
  final String errorMessage;
  final RequestStatus createPostState;
  final PostModel? createdPost;


  const PostStates(
      {
        this.createPostState=RequestStatus.initial,
        this.getPostState = RequestStatus.initial,
      this.posts = const [],
      this.errorMessage = '',
        this.createdPost
      });

  PostStates copyWith({
     RequestStatus? getPostState,
     List<PostModel>? posts,
     String? errorMessage,
    RequestStatus? createPostState,
    PostModel? createdPost
})
  {
    return PostStates(
      getPostState: getPostState??this.getPostState,
      posts: posts??this.posts,
      errorMessage: errorMessage??this.errorMessage,
      createPostState: createPostState??this.createPostState,
      createdPost: createdPost??this.createdPost
    );
  }

  @override
  List<Object?> get props => [getPostState,posts,errorMessage,createPostState,createdPost];
}
