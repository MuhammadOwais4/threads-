
import 'package:demo/models/user_model.dart';

class ReplyModel {
  int? id;
  String? createdAt;
  String? userId;
  int? postId;
  String? reply;
  UserModel? users;

  ReplyModel(
      {this.id,
      this.createdAt,
      this.userId,
      this.postId,
      this.reply,
      this.users});

  ReplyModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    postId = json['post_id'];
    reply = json['reply'];
    users = json['users'] != null ? UserModel.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    data['post_id'] = postId;
    data['reply'] = reply;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}
