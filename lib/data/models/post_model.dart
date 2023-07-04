class PostModel {
  String? text;
  String? postImage;
  String? studentId;
  String? likes;
  String? time;
  String? image;
  String? fullname;

  PostModel(
      {
        this.text,
        this.postImage,
        this.studentId,
        this.likes,
        this.time,
        this.fullname,
        this.image
      });

  PostModel.fromJson(Map<String, dynamic> json) {
    text = json['text'];
    postImage = json['post_image'];
    studentId = json['student_id'];
    likes = json['likes'];
    time = json['time'];
    fullname = json['fullname'];
    image = json['image'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['text'] = this.text;
    data['post_image'] = this.postImage;
    data['student_id'] = this.studentId;
    data['likes'] = this.likes;
    data['time'] = this.time;
    data['image'] = this.image;
    data['fullname'] = this.fullname;
    return data;
  }
}