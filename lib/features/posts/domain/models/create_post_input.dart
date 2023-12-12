class CreatePostInput {
  String? text;
  String? postImage;
  String? studentId;
  String? time;

  CreatePostInput(
      {
        this.text,
        this.postImage,
        this.studentId,
        this.time,
      });

  static Map<String,dynamic> fromInput(CreatePostInput input)
  {
    return
      {
        "text":input.text,
        "post_image":input.postImage,
        "student_id":input.studentId,
        "time":input.time,
        "likes":"0",
        "firebase_id":"1"
      };
  }

  // CreatePostInput.fromJson(Map<String, dynamic> json) {
  //   text = json['text'];
  //   postImage = json['post_image'];
  //   studentId = json['student_id'];
  //   likes = json['likes'];
  //   time = json['time'];
  //   fullname = json['fullname'];
  //   image = json['image'];
  //   firebase_id=json['firebase_id'];
  // }
  //
  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = new Map<String, dynamic>();
  //   data['text'] = this.text;
  //   data['post_image'] = this.postImage;
  //   data['student_id'] = this.studentId;
  //   data['likes'] = this.likes;
  //   data['time'] = this.time;
  //   data['image'] = this.image;
  //   data['fullname'] = this.fullname;
  //   data['firebase_id']=this.firebase_id;
  //   return data;
  // }
}