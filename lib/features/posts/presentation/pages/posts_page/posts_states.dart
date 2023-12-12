import 'package:graduation/features/posts/domain/models/post_model.dart';

abstract class PostsStates
{
  final List<PostModel> posts;
  final String? errorMessage;

  PostsStates({this.posts=const[], this.errorMessage});
}

class PostsInitialStates extends PostsStates{}
class GetPostLoadingStates extends PostsStates{}

class GetPostSuccessStates extends PostsStates{

  GetPostSuccessStates({super.posts});
}

class GetPostErrorStates extends PostsStates{
  GetPostErrorStates({super.errorMessage});
}

class CreatePostLoadingStates extends PostsStates{}

class CreatePostSuccessStates extends PostsStates{
  CreatePostSuccessStates();
}

class CreatePostErrorStates extends PostsStates{
  CreatePostErrorStates({super.errorMessage});
}