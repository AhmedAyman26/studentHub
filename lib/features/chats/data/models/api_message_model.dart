class ApiMessageModel {
  String? senderId;
  String? receiverId;
  String? dateTime;
  String? text;
  String? image;

  ApiMessageModel({
    this.senderId,
    this.receiverId,
    this.dateTime,
    this.text,
    this.image,
  });

  ApiMessageModel.fromJson(Map<String, dynamic> json)
  {
    senderId = json['senderId'];
    receiverId = json['receiverId'];
    dateTime = json['dateTime'];
    text = json['text'];
    image=json['image'];
  }

  Map<String, dynamic> toMap() {
    return
      {
        'senderId': senderId,
        'receiverId': receiverId,
        'dateTime': dateTime,
        'text': text,
        'image':image
      };
  }
}
