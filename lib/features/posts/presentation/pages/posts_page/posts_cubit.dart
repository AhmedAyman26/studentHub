 import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/features/posts/di/posts_di.dart';
import 'package:graduation/features/posts/domain/models/create_post_input.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';
import 'package:graduation/features/posts/domain/usecases/crearte_post_use_case.dart';
import 'package:graduation/features/posts/domain/usecases/get_posts_use_case.dart';
import 'package:graduation/features/posts/presentation/pages/posts_page/posts_states.dart';

class PostsCubit extends Cubit<PostsStates>
 {
   static PostsCubit get(context)=>BlocProvider.of(context);
   late  GetPostsUseCase _getPostsUseCase;
   late final CreatePostUseCase _createPostUseCase;
   PostsCubit():super(PostsInitialStates())
   {
     _loadInjector();
   }

   void _loadInjector()
   {
     _getPostsUseCase=injector();
     _createPostUseCase=injector();
   }

   void getPost()async{
     emit(GetPostLoadingStates());
     try {
       final posts = await _getPostsUseCase.call();
       emit(GetPostSuccessStates(posts: posts));
     }
     catch(error)
     {
       print(error);
       emit(GetPostErrorStates(errorMessage: error.toString()));
     }
   }

   // PostModel? postModel;
   Future<void> addPost(CreatePostInput input)async
   {
     emit(CreatePostLoadingStates());
     try{
       await _createPostUseCase.call(input);
       emit(CreatePostSuccessStates());
     }catch(e)
     {
       emit(CreatePostErrorStates(errorMessage: e.toString()));
       print(e.toString());
     }
   }
 }
