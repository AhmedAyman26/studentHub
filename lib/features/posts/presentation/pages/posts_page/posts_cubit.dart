import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/common/utils/utils.dart';
import 'package:graduation/features/posts/di/posts_di.dart';
import 'package:graduation/features/posts/domain/models/create_post_input.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';
import 'package:graduation/features/posts/domain/usecases/crearte_post_use_case.dart';
import 'package:graduation/features/posts/domain/usecases/get_posts_use_case.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_states.dart';

class PostsCubit extends Cubit<PostStates> {
  static PostsCubit get(context) => BlocProvider.of(context);
  late GetPostsUseCase _getPostsUseCase;
  late final CreatePostUseCase _createPostUseCase;

  PostsCubit() : super(const PostStates()) {
    _loadInjector();
  }

  void _loadInjector() {
    _getPostsUseCase = injector();
    _createPostUseCase = injector();
  }

  Future<void> getPost() async {
    emit(state.copyWith(getPostState: RequestStatus.loading));
    try {
      final posts = await _getPostsUseCase.call();
      posts.sort((a, b) => b.postDate!.compareTo(a.postDate!),);
      emit(state.copyWith(getPostState: RequestStatus.success, posts: posts));
    } catch (error) {
      emit(state.copyWith(
          getPostState: RequestStatus.error, errorMessage: error.toString()));
    }
  }

  void addPost(CreatePostInput input) async {
    emit(state.copyWith(createPostState: RequestStatus.loading));
    try {
      final createdPost = await _createPostUseCase.call(input);
      emit(state.copyWith(createPostState: RequestStatus.success,createdPost: createdPost));
    } catch (e) {
      emit(state.copyWith(
          createPostState: RequestStatus.error, errorMessage: e.toString()));
    }
  }

  void updatePostsList(PostModel post)
  {
    final posts = [...state.posts];
    posts.insert(0, post);
    emit(state.copyWith(posts: posts));
  }
  @override
  void emit(PostStates state) {
    if (!isClosed) {
      super.emit(state);
    }
  }
}
