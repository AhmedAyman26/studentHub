
class ApiPostModel {
  final bool? success;
  final String? message;
  final List<ApiPostData>? posts;

  ApiPostModel({
    this.success,
    this.message,
    this.posts,
  });

  factory ApiPostModel.fromJson(Map<String, dynamic> json) => ApiPostModel(
    success: json["success"],
    message: json["message"],
    posts: json["posts"] == null ? [] : List<ApiPostData>.from(json["posts"].map((x) => ApiPostData.fromJson(x))),
  );

}

class ApiPostData {
  final String? postId;
  final String? text;
  final String? postImage;
  final String? studentId;
  final String? likes;
  final String? time;
  final String? firebaseId;
  final String? fullname;
  final String? image;

  ApiPostData({
    this.postId,
    this.text,
    this.postImage,
    this.studentId,
    this.likes,
    this.time,
    this.firebaseId,
    this.fullname,
    this.image,
  });

  factory ApiPostData.fromJson(Map<String, dynamic> json) => ApiPostData(
    postId: json["post_id"],
    text: json["text"],
    postImage: json["post_image"],
    studentId: json["student_id"],
    likes: json["likes"],
    time: json["time"],
    firebaseId: json["firebase_id"],
    fullname: json["fullname"],
    image: json["image"],
  );

}
