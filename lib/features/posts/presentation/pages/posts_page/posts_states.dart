import 'package:equatable/equatable.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';
import 'package:graduation/shared/utils.dart';

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
// abstract class PostsStates
// {
//   final List<PostModel> posts;
//   final String? errorMessage;
//
//   PostsStates({this.posts=const[], this.errorMessage});
// }
//
// class PostsInitialStates extends PostsStates{}
// class GetPostLoadingStates extends PostsStates{}
//
// class GetPostSuccessStates extends PostsStates{
//
//   GetPostSuccessStates({super.posts});
// }
//
// class GetPostErrorStates extends PostsStates{
//   GetPostErrorStates({super.errorMessage});
// }
//
// class CreatePostLoadingStates extends PostsStates{}
//
// class CreatePostSuccessStates extends PostsStates{
//   CreatePostSuccessStates();
// }
//
// class CreatePostErrorStates extends PostsStates{
//   CreatePostErrorStates({super.errorMessage});
// }
