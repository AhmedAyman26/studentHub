import 'package:get_it/get_it.dart';
import 'package:graduation/features/posts/data/repository/post_repository_impl.dart';
import 'package:graduation/features/posts/domain/repository/post_repository.dart';
import 'package:graduation/features/posts/domain/usecases/crearte_post_use_case.dart';
import 'package:graduation/features/posts/domain/usecases/get_posts_use_case.dart';

final injector = GetIt.instance;

Future<void> init() async {

  // usecases
  injector.registerFactory(() => GetPostsUseCase(injector()));
  injector.registerFactory(() => CreatePostUseCase(injector()));
  // repository
  injector.registerLazySingleton<PostRepository>(() => PostRepositoryImpl(
  ));


}