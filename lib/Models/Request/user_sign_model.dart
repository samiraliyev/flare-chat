class UserSignModel {
  String? email;
  String? password;
  String? imgUrl;
  String? userId;
  String? username;

  UserSignModel({this.email, this.password, this.imgUrl, this.userId, this.username});

  UserSignModel.fromJson(Map<String, dynamic> json) {
    email = json['email'];
    password = json['password'];
    imgUrl = json['imgUrl'];
    userId = json['userId'];
    username = json['username'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['email'] = email;
    data['password'] = password;
    data['imgUrl'] = imgUrl;
    data['userId'] = userId;
    data['username'] = username;
    return data;
  }
}
