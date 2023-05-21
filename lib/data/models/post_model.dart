class PostModel {
  String? postId;
  String? name;
  String? text;
  String? image;
  String? studentId;
  String? likes;
  String? dateTime;

  PostModel(
      {this.postId,
        this.name,
        this.text,
        this.image,
        this.studentId,
        this.likes,
        this.dateTime});

  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    name = json['name'];
    text = json['text'];
    image = json['image'];
    studentId = json['student_id'];
    likes = json['likes'];
    dateTime = json['dateTime'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['post_id'] = this.postId;
    data['name'] = this.name;
    data['text'] = this.text;
    data['image'] = this.image;
    data['student_id'] = this.studentId;
    data['likes'] = this.likes;
    data['time'] = this.dateTime;
    return data;
  }
}