import 'package:graduation/features/posts/data/models/api_post_model.dart';
import 'package:graduation/features/posts/domain/models/post_model.dart';

extension ApiPostMapper on ApiPostData
{
  PostModel map()
  {
    return PostModel(
      postDate: time??'',
      postImage: postImage??'',
      text: text??'',
      userImage:  image??'',
      userName: fullname??''
    );
  }
}