import 'dart:convert';

import 'package:graduation/data/web_services/dio_helper.dart';
import 'package:graduation/features/posts/data/mappers/api_post_mapper.dart';
import 'package:graduation/features/posts/data/models/api_post_model.dart';
import 'package:graduation/features/posts/domain/models/create_post_input.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';
import 'package:graduation/features/posts/domain/repository/post_repository.dart';

class PostRepositoryImpl extends PostRepository {

  @override
  Future<void> addPost(CreatePostInput input) async {
    final request=await DioHelper.postData(
          url: 'post.php', data: CreatePostInput.fromInput(input));
    if(request.statusCode!=200)
    {
      throw Exception(request.statusMessage);
    }
    return;
  }

  @override
  Future<List<PostModel>> getPosts() async {
      final request = await DioHelper.getData(url: 'getpost.php');
      if(request.statusCode!=200)
      {
        throw Exception(request.statusMessage);
      }else{
      final result = ApiPostModel
          .fromJson(jsonDecode(request.data))
          .posts;
      return result?.map((e) => e.map()).toList() ?? [];
  }}
}