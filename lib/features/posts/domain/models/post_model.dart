import 'package:equatable/equatable.dart';

class PostModel extends Equatable
{
  final String? userImage;
  final String? userName;
  final String? text;
  final String? postImage;
  final String? postDate;

  const PostModel({required this.userImage,required this.userName,required this.text,required this.postImage, required this.postDate});

  PostModel.initial() : this(userName: '',userImage: '',text: '',postDate: "",postImage: '');

  @override
  List<Object?> get props => [userImage,userName,text,postImage,postDate];
}