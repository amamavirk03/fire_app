class UserModel {
  User? user;
  String? token;
  String? message;
  bool? success;

  UserModel({this.user, this.token, this.message, this.success});

  UserModel.fromJson(Map<String, dynamic> json) {
    user = json['user_'] != null ? User.fromJson(json['user_']) : null;
    token = json['token'];
    message = json['message'];
    success = json['success'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (user != null) {
      data['user_'] = user!.toJson();
    }
    data['token'] = token;
    data['message'] = message;
    data['success'] = success;
    return data;
  }
}

class User {
  String? sId;
  String? name;
  String? email;
  int? followers;
  int? following;

  List<dynamic>? posts;
  List<dynamic>? likedPosts;
  List<dynamic>? savedPosts;
  int? iV;

  User(
      {this.sId,
      this.name,
      this.email,
      this.followers,
      this.following,
      this.posts,
      this.likedPosts,
      this.savedPosts,
      this.iV});

  User.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    name = json['name'];
    email = json['email'];
    followers = json['followers'];
    following = json['following'];
    if (json['posts'] != null) {
      posts = List<dynamic>.from(json['posts']);
    }
    if (json['likedPosts'] != null) {
      likedPosts = List<dynamic>.from(json['likedPosts']);
    }
    if (json['savedPosts'] != null) {
      savedPosts = List<dynamic>.from(json['savedPosts']);
    }
    iV = json['__v'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['name'] = name;
    data['email'] = email;
    data['followers'] = followers;
    data['following'] = following;
    if (posts != null) {
      data['posts'] = posts;
    }
    if (likedPosts != null) {
      data['likedPosts'] = likedPosts;
    }
    if (savedPosts != null) {
      data['savedPosts'] = savedPosts;
    }
    data['__v'] = iV;
    return data;
  }
}
