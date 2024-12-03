
import 'package:demo/models/user_model.dart';

class PostModel {
  int? postId;
  String? content;
  String? image;
  int? likeCount;
  int? commentCount;
  String? createdAt;
  String? userId;
  UserModel? users;

  PostModel(
      {this.postId,
      this.content,
      this.image,
      this.likeCount,
      this.commentCount,
      this.createdAt,
      this.userId,
      this.users});

  PostModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    content = json['content'];
    image = json['image'];
    likeCount = json['like_count'];
    commentCount = json['comment_count'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    users = json['users'] != null ? UserModel.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['content'] = content;
    data['image'] = image;
    data['like_count'] = likeCount;
    data['comment_count'] = commentCount;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}
