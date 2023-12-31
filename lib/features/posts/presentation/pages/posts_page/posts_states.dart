import 'package:equatable/equatable.dart';
import 'package:graduation/common/utils.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';

class PostStates extends Equatable {
  final RequestStatus getPostState;
  final List<PostModel> posts;
  final String errorMessage;
  final RequestStatus createPostState;


  const PostStates(
      {
        this.createPostState=RequestStatus.initial,
        this.getPostState = RequestStatus.initial,
      this.posts = const [],
      this.errorMessage = ''});

  PostStates copyWith({
     RequestStatus? getPostState,
     List<PostModel>? posts,
     String? errorMessage,
    RequestStatus? createPostState
})
  {
    return PostStates(
      getPostState: getPostState??this.getPostState,
      posts: posts??this.posts,
      errorMessage: errorMessage??this.errorMessage,
      createPostState: createPostState??this.createPostState
    );
  }

  @override
  List<Object?> get props => [getPostState,posts,errorMessage,createPostState];
}
