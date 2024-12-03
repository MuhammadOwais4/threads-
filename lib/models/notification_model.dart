
import 'package:demo/models/user_model.dart';

class NotificationModel {
  int? postId;
  String? notification;
  String? createdAt;
  String? userId;
  UserModel? users;

  NotificationModel(
      {this.postId,
      this.notification,
      this.createdAt,
      this.userId,
      this.users});

  NotificationModel.fromJson(Map<String, dynamic> json) {
    postId = json['post_id'];
    notification = json['notification'];
    createdAt = json['created_at'];
    userId = json['user_id'];
    users = json['users'] != null ? UserModel.fromJson(json['users']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['post_id'] = postId;
    data['notification'] = notification;
    data['created_at'] = createdAt;
    data['user_id'] = userId;
    if (users != null) {
      data['users'] = users!.toJson();
    }
    return data;
  }
}
