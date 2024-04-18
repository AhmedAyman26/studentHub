
import 'package:graduation/features/posts/data/models/api_post_model.dart';

class ApiCreatePostResult {
  final bool? success;
  final String? message;
  final ApiPostData? post;

  ApiCreatePostResult({
    this.success,
    this.message,
    this.post,
  });

  factory ApiCreatePostResult.fromJson(Map<String, dynamic> json) => ApiCreatePostResult(
    success: json["success"],
    message: json["message"],
    post: json["post"] == null ? null : ApiPostData.fromJson(json["post"]),
  );

}
