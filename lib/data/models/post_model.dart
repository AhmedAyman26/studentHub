class PostModel {
  bool? success;
  String? message;
  Post? post;

  PostModel({this.success, this.message, this.post});

  PostModel.fromJson(Map<String, dynamic> json) {
    success = json['success'];
    message = json['message'];
    post = json['post'] != null ? new Post.fromJson(json['post']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['success'] = this.success;
    data['message'] = this.message;
    if (this.post != null) {
      data['post'] = this.post!.toJson();
    }
    return data;
  }
}

class Post {
  String? postId;
  String? text;
  String? image;
  String? studentId;
  String? likes;
  String? time;

  Post(
      {this.postId,
        this.text,
        this.image,
        this.studentId,
        this.likes,
        this.time});

  Post.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    text = json['text'];
    image = json['image'];
    studentId = json['student_id'];
    likes = json['likes'];
    time = json['time'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['text'] = this.text;
    data['image'] = this.image;
    data['student_id'] = this.studentId;
    data['likes'] = this.likes;
    data['time'] = this.time;
    return data;
  }
}