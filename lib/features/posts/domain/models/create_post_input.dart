class CreatePostInput {
  String? text;
  String? postImage;
  String? studentId;
  String? time;
  String? firebaseId;

  CreatePostInput(
      {
        this.text,
        this.postImage,
        this.studentId,
        this.time,
        this.firebaseId
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
        "firebase_id":input.firebaseId};
  }
}